-- CreateTable
CREATE TABLE `USERS` (
    `USER_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(191) NOT NULL,
    `ID` VARCHAR(191) NOT NULL,
    `PASSWORD` VARCHAR(191) NOT NULL,
    `GEM` INTEGER NOT NULL,

    PRIMARY KEY (`USER_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OWN_TOWERS` (
    `TOWER_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `USER_ID` INTEGER NOT NULL,
    `ID` INTEGER NOT NULL,
    `UPGRADE` INTEGER NOT NULL,

    PRIMARY KEY (`TOWER_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SCORES` (
    `USER_ID` INTEGER NOT NULL,
    `MAX_SCORE` INTEGER NOT NULL DEFAULT 0,
    `ENDTIME` DATETIME(3) NOT NULL,

    UNIQUE INDEX `SCORES_USER_ID_key`(`USER_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `` (
    `EQUIP_TOWER_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `USER_ID` INTEGER NOT NULL,
    `TOWER_ID` INTEGER NOT NULL,

    PRIMARY KEY (`EQUIP_TOWER_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `OWN_TOWERS` ADD CONSTRAINT `OWN_TOWERS_USER_ID_fkey` FOREIGN KEY (`USER_ID`) REFERENCES `USERS`(`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SCORES` ADD CONSTRAINT `SCORES_USER_ID_fkey` FOREIGN KEY (`USER_ID`) REFERENCES `USERS`(`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `` ADD CONSTRAINT `_TOWER_ID_fkey` FOREIGN KEY (`TOWER_ID`) REFERENCES `OWN_TOWERS`(`TOWER_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
