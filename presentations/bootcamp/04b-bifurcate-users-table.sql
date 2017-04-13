-- alter tables to have same collations to be able to create foreign key constraints
ALTER TABLE merchants CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

-- make sku_table optional so furtive sees empty data for sku-less merchants
ALTER TABLE merchants MODIFY COLUMN sku_table varchar(25) NULL DEFAULT NULL;

-- fix the MODIFIED column so it defaults to a sensible value
-- (this column is deprecated but still fails when the defaults are used in inserts)
ALTER TABLE merchants MODIFY COLUMN MODIFIED timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP;
UPDATE merchants SET MODIFIED = CREATED where MODIFIED = '0000-00-00 00:00:00';

-- copy the stores from users to merchants
DROP TABLE IF EXISTS tmp_merchant_users;

CREATE TABLE tmp_merchant_users
  SELECT * FROM users where level = 'store';

INSERT INTO merchants (merchant_id, `name`, store_url, baseline_sampling_enabled, baseline_sampling_percentage, created_at, updated_at)
  SELECT guid, `name`, store_url, baseline_sampling_enabled, baseline_sampling_percentage, created_at, updated_at FROM tmp_merchant_users
  ON DUPLICATE KEY UPDATE merchant_id = guid,
    merchants.store_url = tmp_merchant_users.store_url,
    merchants.`name` = tmp_merchant_users.`name`,
    merchants.baseline_sampling_enabled = tmp_merchant_users.baseline_sampling_enabled,
    merchants.baseline_sampling_percentage = tmp_merchant_users.baseline_sampling_percentage;

-- add `merchant_guid` column to `user_merchant`
ALTER TABLE user_merchant ADD COLUMN merchant_guid varchar(50) DEFAULT NULL;

-- drop foreign key / not-null constraint on old merchant_id column in user_merchant, which refers to users
ALTER TABLE user_merchant DROP FOREIGN KEY user_merchant_ibfk_2;
ALTER TABLE user_merchant MODIFY COLUMN merchant_id int(11) NULL DEFAULT NULL;
ALTER TABLE user_merchant CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

-- remove parent_id for all "store" (merchant) users
UPDATE users SET parent_id = NULL WHERE level = 'store';

-- add/update entries to `user_merchant` based on `parent_id` in `users`
INSERT INTO user_merchant (user_id, merchant_guid)
  SELECT u.id, m.guid FROM users u INNER JOIN users m ON u.parent_id = m.id;

-- update `user_merchant` entries to include `merchant_guid`
UPDATE user_merchant SET merchant_guid = (SELECT guid from users where users.id = user_merchant.merchant_id) WHERE merchant_id IS NOT NULL;

-- remove collation from map_protections, merchant_rules to allow foreign key creation
ALTER TABLE map_protections CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE merchant_rules CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

-- add `merchant_id` to referring tables
ALTER TABLE blacklist_settings ADD COLUMN merchant_id varchar(50) DEFAULT NULL;
ALTER TABLE map_protections ADD COLUMN merchant_id varchar(50) DEFAULT NULL;
ALTER TABLE promotion_settings ADD COLUMN merchant_id varchar(50) DEFAULT NULL;
ALTER TABLE merchant_rules ADD COLUMN merchant_id varchar(50) DEFAULT NULL;
ALTER TABLE segments CHANGE COLUMN guid merchant_id VARCHAR(50) DEFAULT NULL;
ALTER TABLE delivery_rules CHANGE COLUMN guid merchant_id VARCHAR(50) DEFAULT NULL;

ALTER TABLE audits ADD COLUMN merchant_id varchar(50) DEFAULT NULL;

-- fill `merchant_id` with `guid` from users table (including `users`)
UPDATE blacklist_settings SET merchant_id = (SELECT guid FROM users where users.id = blacklist_settings.user_id);
UPDATE map_protections SET merchant_id = (SELECT guid FROM users where users.id = map_protections.user_id);
UPDATE promotion_settings SET merchant_id = (SELECT guid FROM users where users.id = promotion_settings.user_id);
UPDATE merchant_rules SET merchant_id = (SELECT guid FROM users where users.id = merchant_rules.user_id);

UPDATE audits SET merchant_id = (SELECT guid FROM users where users.id = audits.user_id);

-- create `user_merchant` foreign key using `merchant_guid`
ALTER TABLE user_merchant MODIFY COLUMN merchant_guid varchar(50) NOT NULL;
ALTER TABLE user_merchant ADD FOREIGN KEY fk_user_merchant_merchant_id (merchant_guid) REFERENCES merchants (merchant_id) ON DELETE CASCADE;

-- create foreign keys between referring tables and `merchants`
ALTER TABLE blacklist_settings ADD FOREIGN KEY fk_blacklist_settings_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;
ALTER TABLE map_protections ADD FOREIGN KEY fk_map_protections_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;
ALTER TABLE promotion_settings ADD FOREIGN KEY fk_promotion_settings_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;
ALTER TABLE merchant_rules ADD FOREIGN KEY fk_merchant_rules_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;
ALTER TABLE segments ADD FOREIGN KEY fk_segments_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;
ALTER TABLE delivery_rules ADD FOREIGN KEY fk_delivery_rules_merchant_id (merchant_id) REFERENCES merchants (merchant_id) ON DELETE CASCADE;

-- drop old `merchant_id` column from `user_merchant` and rename `merchant_guid` to `merchant_id`
ALTER TABLE user_merchant DROP COLUMN merchant_id;
ALTER TABLE user_merchant CHANGE COLUMN merchant_guid merchant_id varchar(50) NOT NULL;

-- drop `user_id` from referring tables
ALTER TABLE blacklist_settings DROP COLUMN user_id;
ALTER TABLE map_protections DROP COLUMN user_id;
ALTER TABLE promotion_settings DROP COLUMN user_id;
ALTER TABLE merchant_rules DROP COLUMN user_id;

ALTER TABLE audits DROP COLUMN user_id;

-- delete stores from `users`
DELETE FROM users WHERE level = 'store';

-- drop merchant columns from `users` table
ALTER TABLE users DROP INDEX unique_email_for_guid;
ALTER TABLE users
  DROP COLUMN guid,
  DROP COLUMN store_url,
  DROP COLUMN baseline_sampling_percentage,
  DROP COLUMN baseline_sampling_enabled;

-- drop parent_id from users as all user merchant relationships are in user_merchant table
ALTER TABLE users DROP INDEX index_users_on_parent_id;
ALTER TABLE users DROP COLUMN parent_id;

-- Finally, remove the temp table
DROP TABLE tmp_merchant_users;
