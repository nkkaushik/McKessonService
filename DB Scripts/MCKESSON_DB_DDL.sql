DROP SCHEMA mckesson; 

CREATE SCHEMA `mckesson` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci ;

USE mckesson;

SET FOREIGN_KEY_CHECKS=0;

/* `usrmgmt.people` used for reference*/
create table `people` (
  `id` bigint(20) not null auto_increment comment 'people table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='people table';

/*`order.orders` used for reference  */
create table `orders` (
  `id` bigint(20) not null auto_increment comment 'orders table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='orders table';

/* `config.products` used for reference*/
create table `products` (
  `id` bigint(20) not null auto_increment comment 'product table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='products table';


/*table structure definition for new table config.notes */
create table `notes` (
  `id` bigint(20) not null auto_increment comment 'primary key for table notes',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='notes for peoples';

/* `config.company` used for reference*/
create table `company` (
  `id` bigint(20) not null auto_increment comment 'company table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='company table';  


/* `config.carrier_service_types` used for reference*/
create table `carrier_service_types` (
  `id` bigint(20) not null auto_increment comment 'carrier service type table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='carrier service type table';

/*table structure definition for new table config.product_packages */
/* table name - productpackages change to  product_packages */
create table `product_packages` (
  `id` bigint(20) not null auto_increment comment 'primary key for table product_packages',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
)  engine=innodb default charset=latin1 comment='product packages table';

/* `config.people_product_refills` used for reference
create table `people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primay key for people_product_refills',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='people product refill details';
*/

CREATE TABLE `pharmacy_fullfillment_trackings` (
  `id` bigint(20) not null auto_increment comment 'pharmacy_fullfillment_tracking table primary key column',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`)
) engine=innodb default charset=latin1 comment='pharmacy_fullfillment_tracking';

-- rpeopletoexternalpeople renamed as people_mapping_externalpeople

create table `external_people` (
  `id` bigint(20) not null auto_increment comment 'primary key for table external_people',
  `people_id` bigint(20) not null comment 'people_id fk from people table',
  `external_people_id` varchar(100) not null comment 'external source people_id ',
  `external_source` varchar(100) not null comment 'external source details',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_externalpeoples_people_people_id` foreign key (`people_id`) references `people` (`id`),
  constraint `fk_externalpeoples_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_externalpeoples_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='relation for people to external source people';

/*table structure for new table `usrmgmt.people_product_refills` */
/* table name - peopleproductrefill change to  people_product_refills */
create table `people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primary key for people_product_refills table',
  `people_id` bigint(20) not null comment 'people_id fk from people table',
  `product_id` bigint(20) not null comment 'product_id fk from product table',
  `product_group` varchar(255) not null comment 'product group name',
  `pill_count` int(11) not null comment 'pills count',
  `refill_count` int(11) default null comment 'refill count',
  `expiration_date` datetime default null comment 'expiry date of pills',
  `declined` smallint(6) not null default '0' comment 'declined flag',
  `declined_note_id` bigint(20) default null comment 'declined noteid flag',
  `is_approved` smallint(6) not null default '0' comment 'approved flag' ,
  `ttl_pills` int(11) not null default '0' comment 'ttl pills details',
  `ttl_pills_remaining` int(11) not null default '0' comment 'ttl pills remaining details',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_peopleproductrefills_people_people_id` foreign key (`people_id`) references `people` (`id`),
  constraint `fk_peopleproductrefills_products_product_id` foreign key (`product_id`) references `products` (`id`),
  constraint `fk_peopleproductrefills_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_peopleproductrefills_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb  default charset=latin1 avg_row_length=114 comment='people product refill details';

/*table structure for table `doctors_people_product_refills` */
/* table name - rpeopleproductrefilltodoctor change to  doctors_people_product_refills */
create table `doctors_people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primary key for doctors_people_product_refills table',
  `doctor_id` bigint(20) not null comment 'people_id fk from people table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `source` varchar(128) default null comment 'source info',
  `source_detail` varchar(255) default null comment 'source info details',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_doctorspeopleproductrefills_people_doctor_id` foreign key (`doctor_id`) references `people` (`id`),
  constraint `fk_doctorspeopleproductrefills_peopleproductrefill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`),
  constraint `fk_doctorspeopleproductrefills_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_doctorspeopleproductrefills_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 avg_row_length=210 comment='people product refills relation with doctor table';

/*table structure for new table `usrmgmt.map_people_product_refills` */
/* table name - rpeopleproductrefilltomap change to  map_people_product_refills */
create table `map_people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primary key for map_people_product_refills table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `people_id` bigint(20) default null comment 'people_id fk from people table #old column name patientid#',
  `old_script_id` bigint(20) default null comment 'old script id details',
  `new_script_id` bigint(20) default null comment 'new script id details',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mappeopleproductrefills_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mappeopleproductrefills_people_updated_by` foreign key (`updated_by`) references `people` (`id`),
  constraint `fk_mappeopleproductrefills_people_people_id` foreign key (`people_id`) references `people` (`id`),
  constraint `fk_mappeopleproductrefills_people_product_refill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`)
) engine=innodb auto_increment=13820 default charset=latin1 comment='relation for people product refills mapping for old and new scripts';

/*table structure for table `notes_people_product_refills` */
/* table name - rpeopleproductrefilltonote change to  notes_people_product_refills */
create table `notes_people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primary key for notes_people_product_refills table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `note_id` bigint(20) not null comment 'noteid fk from notes table',
  `note_type_id` tinyint(4) not null comment 'note type id ',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_notespeopleproductrefills_to_note_people_product_refill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`),
  constraint `fk_notespeopleproductrefills_to_note_note_noteid` foreign key (`note_id`) references `notes` (`id`),
  constraint `fk_notespeopleproductrefills_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_notespeopleproductrefills_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='people product refills relation with note table';

/*table structure for new table `usrmgmt.pharmacy_people_product_refills` */
/* table name - rpeopleproductrefilltopharmacy change to  pharmacy_people_product_refills */
create table `pharmacy_people_product_refills` (
  `id` bigint(20) not null auto_increment comment 'primary key for pharmacy_people_product_refills table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `pharmacy_id` bigint(20) not null comment 'pharmacy_id fk from company table',
  `external_rx_id` varchar(150) default null comment 'external rx id for pharmacy',
  `external_source` varchar(150) default null comment 'external source id for pharmacy',
  `external_rx_num` varchar(100) default null comment 'external rx number for pharmacy',
  `external_ndc` varchar(100) default null comment 'external ndc for pharmacy',
  `external_days_supply` varchar(100) default null comment 'external days supply for pharmacy',
  `ndc` varchar(100) default null comment 'national drug code',
  `days_supply` int(11) default null comment 'days supply for pharmacy',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_pharmacypeopleproductrefills_people_product_refill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`),
  constraint `fk_pharmacypeopleproductrefills_company_pharmacy_id` foreign key (`pharmacy_id`) references `company` (`id`),
  constraint `fk_pharmacypeopleproductrefills_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_pharmacypeopleproductrefills_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 avg_row_length=61 comment='relation for people product refill to pharmacy';

/*table structure for new table `usrmgmt.people_product_refills_orders` */
/* table name - rpeopleproductrefilltoorder change to  people_product_refills_orders */
create table `people_product_refills_orders` (
  `id` bigint(20) not null auto_increment comment 'primary key for people_product_refills_orders table',
  `order_id` bigint(20) not null  comment 'original order id fk from order table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `product_id` bigint(20) not null default '0' comment 'product_id fk from product table',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_peopleproductrefillsorders_people_product_refill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`),
  constraint `fk_peopleproductrefillsorders_products_product_id` foreign key (`product_id`) references `products` (`id`),
  constraint `fk_peopleproductrefillsorders_orders_orderid_orig` foreign key (`order_id`) references `orders` (`id`),
  constraint `fk_peopleproductrefillsorders_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_peopleproductrefillsorders_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 avg_row_length=195  comment='relation for people product refill to orders';

/*table structure for new table `usrmgmt.people_product_refills_signatures` */
/* table name - rpeopleproductrefilltosig change to  people_product_refills_signatures */
create table `people_product_refills_signatures` (
  `id` bigint(20) not null auto_increment comment 'primary key for people_product_refills_signatures table',
  `people_product_refill_id` bigint(20) not null comment 'people_product_refill_id fk from people_product_refills table',
  `sig_text` varchar(2000) default null comment 'signature text',
  `orig_order_id` bigint(20) default null comment 'original order id', 
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_peopleproductrefillssignatures_people_product_refill_id` foreign key (`people_product_refill_id`) references `people_product_refills` (`id`),
  constraint `fk_peopleproductrefillssignatures_orders_orderid_orig` foreign key (`orig_order_id`) references `orders` (`id`),
  constraint `fk_peopleproductrefillssignatures_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_peopleproductrefillssignatures_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='relation for people product refill to sig';



/*table structure definition for new table config.product_inventory */
/* table name - productinventory change to  product_inventory */
create table `product_inventory` (
  `id` bigint(20) not null auto_increment comment 'primary key for table product_inventory',
  `package_id` bigint(20) not null comment 'package id of product',
  `scan_code` varchar(100) default null comment 'scan code of product',
  `lot_code` varchar(50) default null comment 'lot code of product',
  `people_id` bigint(20) default null comment 'people_id fk from people table',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_productinventory_company_id` foreign key (`package_id`) references `product_packages` (`id`),
  constraint `fk_productinventory_people_people_id` foreign key (`people_id`) references `people` (`id`),
  constraint `fk_productinventory_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_productinventory_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='product inventory details ';

/*table structure definition for new table config.product_inventory_orders */
/* table name - productinventoryorders change to  product_inventory_orders */
create table `product_inventory_orders` (
  `id` bigint(20) not null auto_increment comment 'primary key for table product_inventory_orders',
  `order_id` bigint(20) not null  comment 'order id fk from order table',
  `product_id` bigint(20) default null,
  `inventory_id` bigint(20) not null,
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  key `idx_product_inventory_orders_1` (`order_id`,`inventory_id`,`is_deleted`),
  key `idx_product_inventory_orders_2` (`inventory_id`,`order_id`,`is_deleted`),
  constraint `fk_productinventoryorders_orders_order_id` foreign key (`order_id`) references `orders` (`id`),
  constraint `fk_productinventoryorders_product_product_id` foreign key (`product_id`) references `products` (`id`),
  constraint `fk_productinventoryorders_productinventory_inventory_id` foreign key (`inventory_id`) references `product_inventory` (`id`),
  constraint `fk_productinventoryorders_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_productinventoryorders_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='product inventory orders details ';


/*table structure for table `mckesson product config` */
-- mckesson product config -  currently not in use, but upscript is planning to use it 
/*product ndc can be removed or added into products table it will become a part of whereever product table created*/
create table `mckesson_product_configs` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_product_config',
  `product_id` bigint(20) default null comment 'product id',
  `product_ndc` varchar(255) default null comment 'product national drug code - ndc',
  `carrier_service_type_id` bigint(20) default null comment 'carrier service type like fedex first/priority/international',
  `default_qty` int(11) default null comment 'defualt quantity' comment 'default quantity',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonproductconfigs_product_product_id` foreign key (`product_id`) references `products` (`id`),
  constraint `fk_mckessonproductconfig_carrierservicetypecarrierservicetype_id` foreign key (`carrier_service_type_id`) references `carrier_service_types` (`id`),
  constraint `fk_mckessonproductconfigs_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonproductconfigs_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson product config details';

/*table structure for table `mckesson_rx_sold_exceptions` */
create table `mckesson_rx_sold_exceptions` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_rxsold_exception',
  `patient_id` bigint(20) not null comment 'patient id - can be mapped to people id',
  `rx_num` varchar(50) not null default '' comment 'rx num',
  `fill_number` varchar(50) default null comment 'filling number',
  `sold_date` datetime default null comment 'sold date of order ',
  `rx_id` bigint(20) default null comment 'rx_id if fk from people_product_refills table',
  `order_id` bigint(20) default null comment 'order id',
  `product_id` bigint(20) default null comment 'product id',
  `qty_sold` int(11) default null  comment 'number of items sold',
  `qty_remaining` int(11) default null comment 'number of items unsold/remained',
  `pf_order_count` int(11) default null comment 'pf order count',
  `tracking_number` varchar(255) default null comment ' order tracking id',
  `rx_sold_status` smallint(6) default null comment ' rx sold status',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonrxsoldexceptions_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonrxsoldexceptions_product_product_id` foreign key (`product_id`) references `products` (`id`),
  constraint `fk_mckessonrxsoldexceptions_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonrxsoldexceptions_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonrxsoldexceptions_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonrxsoldexceptions_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment=' rx sold exceptions in mckesson';

/*table structure for table `mckesson_script_issues` */
create table `mckesson_script_issues` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_script_issue',
  `order_id` bigint(20) default null comment 'order id',
  `patient_id` bigint(20) default null comment 'patient id - can be mapped to people id',
  `rx_id` bigint(20) default null comment 'rx id',
  `reason_code` varchar(100) default null comment 'reason code',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonscriptissues_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonscriptissues_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonscriptissues_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonscriptissues_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonscriptissues_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson script issue with reason code';

/*table structure for table `mckesson_security` */
create table `mckesson_security` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_security',
  `patient_id` bigint(20) default null comment 'patient id - can be mapped to people id',
  `id_code` varchar(100) default null comment 'alphanumeric code for identification',
  `message_type` varchar(100) default null comment 'type of message -  notes',
  `expire_time` datetime default null comment 'expire time of id code',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonsecurity_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonsecurity_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonsecurity_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson_security definition with id code for identification';

/*table structure for table `mckesson_queue` */
create table `mckesson_queue` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_queue',
  `patient_id` bigint(20) default '0' comment 'patient id - can be mapped to people id',
  `order_id` bigint(20) default '0' comment 'order id',
  `rx_id` bigint(20) default '0' comment 'rx id',
  `message_type` varchar(255) default null comment 'type of the message',
  `message_trigger` varchar(255) default null comment 'trigger of the message',
  `post_message` varchar(255) default null comment 'message post',
  `old_value_id` bigint(20) default null comment 'old value id',
  `old_value_text` varchar(1000) default null comment 'old value  text',
  `new_value_id` bigint(20) default null comment 'new value id',
  `new_value_text` varchar(1000) default null comment 'new value  text',
  `value_type` varchar(255) default null comment ' value  type - system user',
  `sent_count` bigint(20) default null comment ' sent count',
  `message_severity` varchar(255) default null comment ' message priority/importance - low/medium',
  `message_expiration` datetime default null comment ' message expiration date',
  `process_date` datetime default null comment ' processing date',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonqueue_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonqueue_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonqueue_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonqueue_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonqueue_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
 ) engine=innodb default charset=latin1 comment='mckesson queue for order procesing';

/*table structure for table `mckesson_requeue` */
create table `mckesson_requeue` (
  `id` int(11) not null auto_increment comment 'primary key for table mckesson_requeue',
  `order_id` bigint(20) default null comment 'order id',
  `message_type` varchar(255) default null comment 'type of the message',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonrequeue_order_order_id` foreign key (`order_id`) references `orders` (`id`),
  constraint `fk_mckessonrequeue_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonrequeue_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='process table for resending items into mckessonqueue table';

/*table structure for table `mckesson_queue_aux` */
create table `mckesson_queue_aux` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_queue_aux',
  `patient_id` bigint(20) default '0' comment 'patient id - can be mapped to people id',
  `order_id` bigint(20) default '0' comment 'order id',
  `rx_id` bigint(20) default '0' comment 'rx id',
  `message_type` varchar(255) default null comment 'type of the message',
  `message_trigger` varchar(255) default null comment 'trigger of the message',
  `post_message` varchar(255) default null comment 'message post',
  `old_value_id` bigint(20) default null comment 'old value id',
  `old_value_text` varchar(1000) default null comment 'old value  text',
  `new_value_id` bigint(20) default null comment 'new value id',
  `new_value_text` varchar(1000) default null comment 'new value  text',
  `value_type` varchar(255) default null comment ' value  type - system user',
  `sent_count` bigint(20) default null comment ' sent count',
  `message_severity` varchar(255) default null comment ' message priority/importance - low/medium',
  `message_expiration` datetime default null comment ' message expiration date',
  `process_date` datetime default null comment ' processing date',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonqueueaux_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonqueueaux_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonqueueaux_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonqueueaux_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonqueueaux_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson_queue backup table';

/*table structure for table `mckesson_queue_aux2` */
create table `mckesson_queue_aux2` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_queue_aux2',
  `patient_id` bigint(20) default '0' comment 'patient id - can be mapped to people id',
  `order_id` bigint(20) default '0' comment 'order id',
  `rx_id` bigint(20) default '0' comment 'rx id',
  `message_type` varchar(255) default null comment 'type of the message',
  `message_trigger` varchar(255) default null comment 'trigger of the message',
  `post_message` varchar(255) default null comment 'message post',
  `old_value_id` bigint(20) default null comment 'old value id',
  `old_value_text` varchar(1000) default null comment 'old value  text',
  `new_value_id` bigint(20) default null comment 'new value id',
  `new_value_text` varchar(1000) default null comment 'new value  text',
  `value_type` varchar(255) default null comment ' value  type - system user',
  `sent_count` bigint(20) default null comment ' sent count',
  `message_severity` varchar(255) default null comment ' message priority/importance - low/medium',
  `message_expiration` datetime default null comment ' message expiration date',
  `process_date` datetime default null comment ' processing date',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonqueueaux2_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonqueueaux2_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonqueueaux2_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonqueueaux2_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonqueueaux2_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson_queue backup table ';


/*table structure for table `mckesson_rx_issues` */
create table `mckesson_rx_issues` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_rx_issues',
  `patient_id` bigint(20) default null comment 'patient id - can be mapped to people id',
  `rx_id` bigint(20) default null comment 'rx id',
  `process` varchar(155) default null comment 'process of rx issue arise ',
  `message` varchar(300) default null comment 'message of process',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonrxissues_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonrxissues_peopleproductrefills_rx_id` foreign key (`rx_id`) references `people_product_refills` (`id`),
  constraint `fk_mckessonrxissues_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonrxissues_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson rx issues details';

/*table structure for table `mckesson_orders_tracking` */
create table `mckesson_orders_tracking` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_orders_tracking',
  `patient_id` bigint(20) default null comment 'patient id - can be mapped to people id',
  `order_id` bigint(20) default null comment 'order id - can be mapped to order id',
  `process` varchar(255) default null comment 'process',
  `print_count` bigint(20) default null comment 'print count',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonorderstracking_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonorderstracking_orders_order_id` foreign key (`order_id`) references `orders` (`id`), 
  constraint `fk_mckessonorderstracking_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonorderstracking_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson order tracking details';

/*table structure for table `mckesson_returns_tracking` */
create table `mckesson_returns_tracking` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_returns_tracking',
  `patient_id` bigint(20) default null comment 'patient id - can be mapped to people id',
  `rx_id` bigint(20) default null comment 'rx id ',
  `order_id` bigint(20) default null comment 'order id - can be mapped to order id',
  `return_date` datetime default null comment 'order return date',
  `reason_id` int(11) default null comment 'order return reason id',
  `reason_text` varchar(255) default null comment 'order return reason decription',
  `damaged` smallint(6) default null comment '0-not damaged 1-damaged',
  `refill_too_old` smallint(6) default null comment '0- not too old refilling 1-old refilling',
  `inventory_by_pass` smallint(6) default null comment '0-false 1-true',
  `inventory_by_pass_reason_text` varchar(500) default null comment 'if inventory by passed, then its reason',
  `created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonreturnstracking_people_patient_id` foreign key (`patient_id`) references `people` (`id`),
  constraint `fk_mckessonreturnstracking_orders_order_id` foreign key (`order_id`) references `orders` (`id`),
  constraint `fk_mckessonreturnstracking_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonreturnstracking_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson order return tracking details';

/*table structure for table `mckesson_raw_responses` */
create table `mckesson_raw_responses` (
  `id` bigint(20) not null auto_increment comment 'primary key for table mckesson_raw_responses',
  `mckesson_raw_id` varchar(100) default null comment 'alphanumeric mckesson raw id',
  `message_type` varchar(255) default null comment 'type of message',
  `sequence` bigint(20) default null comment 'sequence order',
  `field_name` varchar(255) default null comment 'field of raw response - similar to key',
  `field_data` varchar(2000) default null comment 'field data of raw response - similar to value',
  `parent` varchar(255) default null,`created_at` timestamp not null default now()  comment 'record creation time',
  `created_by` bigint(20) default null comment 'record created by',
  `updated_at` timestamp not null default now() on update now() comment 'record updated time',
  `updated_by` bigint(20) default null comment 'record updated by',
  `is_deleted` tinyint(1) not null default '0' comment '0-active 1-inactive/deleted',
  primary key (`id`),
  constraint `fk_mckessonrawresponses_people_created_by` foreign key (`created_by`) references `people` (`id`),
  constraint `fk_mckessonrawresponses_people_updated_by` foreign key (`updated_by`) references `people` (`id`)
) engine=innodb default charset=latin1 comment='mckesson raw response';

SET FOREIGN_KEY_CHECKS=1;