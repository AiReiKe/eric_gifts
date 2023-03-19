ALTER TABLE `users` ADD COLUMN `have_gift` INT(11) NOT NULL DEFAULT 0;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('new_gift','新手禮包', 100)
;