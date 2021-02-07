USE `essentialmode`;

ALTER TABLE `users` ADD COLUMN `have_gift` INT(11) NOT NULL DEFAULT 0;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('new_gift','新手禮包', 1)
;