-- MySQL Workbench Forward Engineering
CREATE TABLE `daum_news_category` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	`sort` INT(11) NOT NULL,
	PRIMARY KEY (`id`)
)
COMMENT='daum_news_category'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (1, '전체', 1);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (2, '사회', 2);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (3, '정치', 3);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (4, '경제', 4);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (5, '국제', 5);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (6, '문화', 6);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (7, 'IT', 7);
INSERT INTO `daum_news_category` (`id`, `name`, `sort`) VALUES (8, '연제', 8);


CREATE TABLE `daum_news` (
	`id` VARCHAR(50) NOT NULL COMMENT '글번호',
	`reg_date` DATETIME NOT NULL,
	`category_id` INT(11) NOT NULL,
	`thumbnail` VARCHAR(260) NOT NULL,
	`summary` VARCHAR(500) NOT NULL,
	`title_name` VARCHAR(200) NOT NULL,
	`title_contents` TEXT NOT NULL,
	`reporter` VARCHAR(100) NOT NULL COMMENT '기자',
	`newspaper` VARCHAR(100) NOT NULL,
	`open_yn` CHAR(1) NOT NULL DEFAULT 'Y',
	`view_count` INT(11) NOT NULL,
	`link` VARCHAR(200) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_news_category` (`category_id`),
	CONSTRAINT `fk_news_category` FOREIGN KEY (`category_id`) REFERENCES `daum_news_category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COMMENT='daum.news'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
  `id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `passwd` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `category` (
  `id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `user_id` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Post` (
  `id` VARCHAR(45) NOT NULL,
  `category_id` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `content` TEXT NULL,
  `user_id` VARCHAR(45) NULL,
  `reg_date` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comment` (
  `id` VARCHAR(45) NOT NULL,
  `comment_text` VARCHAR(3000) NULL,
  `reg_date` TIMESTAMP NULL,
  `post_id` VARCHAR(45) NULL,
  `user_id` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;






