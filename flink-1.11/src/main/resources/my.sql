-- source表
CREATE TABLE source_table_1 (
      event_id STRING COMMIT '事件编号',
      cd_org_cd STRING COMMIT '信用卡ORG代码',
      acct_num STRING COMMIT '账号',
      acct_modifier_num STRING COMMIT '账号修饰符',
      cust_id STRING COMMIT '客户号',
      card_num STRING COMMIT '卡号',
      card_seq_num STRING COMMIT '卡序号',
      logo_cd STRING COMMIT 'LOGO代码',
      subbranch_id STRING COMMIT '账户所属支行',
      txn_ref_num STRING COMMIT '金融交易参考号',
      txn_type_cd STRING COMMIT '金融交易类型代码',
      txn_dt STRING COMMIT '交易日期',
      batch_dt STRING COMMIT '批量日期',
      posting_dt STRING COMMIT '入账日期',
      cd_plan_num STRING COMMIT '信用计划号',
      txn_cd STRING COMMIT '交易代码',
      logic_module_cd STRING COMMIT '逻辑模块代码',
      txn_amt STRING COMMIT '交易金额',
      rmb_txn_amt STRING COMMIT '交易金额折人民币',
      auth_num    STRING    COMMIT '授权号',
      lty_pgm_num    STRING    COMMIT '积分计划编号',
      txn_pts_nbr    DECIMAL(18,2)    COMMIT '事件积分',
      external_txn_id    STRING    COMMIT '外部交易ID',
      mcc_cd    STRING    COMMIT 'MCC代码',
      equip_card_num    STRING    COMMIT '设备卡号',
      equip_card_type_cd    STRING    COMMIT '设备卡类型代码',
      merchant_country_cd    STRING    COMMIT '商户国家代码',
      merchant_id    STRING    COMMIT '商户编号',
      txn_desc    STRING    COMMIT '交易描述',
      txn_terminal_num    STRING    COMMIT '交易终端编号',
      gl_src_cd    STRING    COMMIT '总账来源代码',
      txn_src_cd    STRING    COMMIT '交易来源代码',
      txn_src_type_cd    STRING    COMMIT '交易来源分类代码',
      currency_conv_type_cd    STRING    COMMIT '货币转换类型代码',
      ec_txn_type_cd    STRING    COMMIT '电子商务交易类型代码',
      curr_conv_charge_mode_cd    STRING    COMMIT '货币转换收费方式代码',
      use_method_cd    STRING    COMMIT '使用方式代码',
      deal_bank_org_id    STRING    COMMIT '受理行机构编号',
      union_pay_sys_trace_num    STRING    COMMIT '银联系统跟踪号',
      spec_fee_type    STRING    COMMIT '特殊计费类型',
      spec_fee_level    STRING    COMMIT '特殊计费档次',
      txn_tm    STRING    COMMIT '交易时间',
      pbc_remittance_biz_id    STRING    COMMIT '人行大小额汇款业务编号',
      extend_merc_name    STRING    COMMIT '扩展商户名称',
      level2_merc_name    STRING    COMMIT '二级商户名称',
      biz_product_type_cd    STRING    COMMIT '业务产品类型代码',
      payer_name    STRING    COMMIT '付款方姓名',
      pay_acct_num    STRING    COMMIT '付款账号',
      payment_remark    STRING    COMMIT '代付附言',
      pbcc_nc_txn_seq_num    STRING    COMMIT '人行网联交易流水号',
      nc_instalment_fee_type_cd    STRING    COMMIT '网联分期手续费收取类型代码',
      nc_instalment_prod_cd    STRING COMMIT '网联分期分期产品代码',
      acqr_bank_id    STRING    COMMIT '收单行行号',
      pay_acct_type_cd    STRING    COMMIT '付款账号类型代码',
      app_service_id    STRING    COMMIT '应用服务方ID',
      org_name    STRING    COMMIT '机构名称',
      biz_desc    STRING    COMMIT '业务描述',
      new_borrow_flage    INT    COMMIT '借贷标记',
      new_account_chinessname STRING  COMMIT '账户中文名',
      match_auth_txn_ind    STRING    COMMIT '匹配到授权交易标志',
      data_dt    STRING    COMMIT '数据日期'
      et AS TO_TIMESTAMP(FROM_UNIXTIME(cast(data_dt as bigint)/1000)),
      WATERMARK FOR et AS et - INTERVAL '5' SECOND
    )
    WITH (
      'connector' = 'kafka',
      'topic' = 'source_table_1',
      'properties.group.id'='dev_flink',
      'properties.zookeeper.connect'='10.1.30.6:2181',
      'properties.bootstrap.servers' = '10.1.30.8:9092',
      'format' = 'json',
      'scan.startup.mode' = 'latest-offset'
      );
-- 结果表
create table sink_table_1(
		xiaofei_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		xiaofei_02 decimal COMMIT '最近1天&Transtype.交易金额',
		xiaofei_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		xiaofei_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		xiaofei_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		xiaofei_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		xiaofei_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		xiaofei_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		xiaofei_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		xiaofei_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		xiaofei_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		xiaofei_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		xiaofei_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		xiaofei_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		xiaofei_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		xiaofei_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		xiaofei_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		xiaofei_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		xiaofei_20 STRING COMMIT '是否最近3天连续&Transtype.',
		xiaofei_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		xiaofei_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		xiaofei_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		xiaofei_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		bangong_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		bangong_02 decimal COMMIT '最近1天&Transtype.交易金额',
		bangong_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		bangong_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		bangong_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		bangong_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		bangong_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		bangong_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		bangong_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		bangong_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		bangong_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		bangong_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		bangong_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		bangong_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		bangong_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		bangong_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		bangong_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		bangong_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		bangong_20 STRING COMMIT '是否最近3天连续&Transtype.',
		bangong_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		bangong_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		bangong_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		bangong_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		xinzi_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		xinzi_02 decimal COMMIT '最近1天&Transtype.交易金额',
		xinzi_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		xinzi_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		xinzi_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		xinzi_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		xinzi_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		xinzi_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		xinzi_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		xinzi_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		xinzi_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		xinzi_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		xinzi_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		xinzi_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		xinzi_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		xinzi_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		xinzi_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		xinzi_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		xinzi_20 STRING COMMIT '是否最近3天连续&Transtype.',
		xinzi_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		xinzi_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		xinzi_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		xinzi_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		baoxian_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		baoxian_02 decimal COMMIT '最近1天&Transtype.交易金额',
		baoxian_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		baoxian_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		baoxian_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		baoxian_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		baoxian_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		baoxian_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		baoxian_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		baoxian_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		baoxian_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		baoxian_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		baoxian_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		baoxian_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		baoxian_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		baoxian_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		baoxian_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		baoxian_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		baoxian_20 STRING COMMIT '是否最近3天连续&Transtype.',
		baoxian_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		baoxian_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		baoxian_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		baoxian_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		touzi_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		touzi_02 decimal COMMIT '最近1天&Transtype.交易金额',
		touzi_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		touzi_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		touzi_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		touzi_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		touzi_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		touzi_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		touzi_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		touzi_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		touzi_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		touzi_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		touzi_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		touzi_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		touzi_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		touzi_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		touzi_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		touzi_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		touzi_20 STRING COMMIT '是否最近3天连续&Transtype.',
		touzi_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		touzi_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		touzi_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		touzi_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		rongzi_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		rongzi_02 decimal COMMIT '最近1天&Transtype.交易金额',
		rongzi_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		rongzi_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		rongzi_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		rongzi_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		rongzi_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		rongzi_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		rongzi_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		rongzi_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		rongzi_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		rongzi_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		rongzi_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		rongzi_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		rongzi_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		rongzi_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		rongzi_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		rongzi_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		rongzi_20 STRING COMMIT '是否最近3天连续&Transtype.',
		rongzi_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		rongzi_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		rongzi_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		rongzi_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		zhuanzhang_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		zhuanzhang_02 decimal COMMIT '最近1天&Transtype.交易金额',
		zhuanzhang_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		zhuanzhang_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		zhuanzhang_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		zhuanzhang_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		zhuanzhang_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		zhuanzhang_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		zhuanzhang_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		zhuanzhang_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		zhuanzhang_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		zhuanzhang_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		zhuanzhang_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		zhuanzhang_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		zhuanzhang_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		zhuanzhang_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		zhuanzhang_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		zhuanzhang_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		zhuanzhang_20 STRING COMMIT '是否最近3天连续&Transtype.',
		zhuanzhang_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		zhuanzhang_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		zhuanzhang_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		zhuanzhang_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		cunqu_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		cunqu_02 decimal COMMIT '最近1天&Transtype.交易金额',
		cunqu_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		cunqu_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		cunqu_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		cunqu_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		cunqu_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		cunqu_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		cunqu_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		cunqu_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		cunqu_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		cunqu_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		cunqu_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		cunqu_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		cunqu_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		cunqu_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		cunqu_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		cunqu_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		cunqu_20 STRING COMMIT '是否最近3天连续&Transtype.',
		cunqu_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		cunqu_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		cunqu_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		cunqu_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万',
		other_01 INTEGER COMMIT '最近1天&Transtype.交易笔数',
		other_02 decimal COMMIT '最近1天&Transtype.交易金额',
		other_03 decimal COMMIT '最近1天&Transtype.最大交易金额',
		other_04 INTEGER COMMIT '最近1天&Transtype.发生交易天数',
		other_05 INTEGER COMMIT '最近1天的日均&Transtype.交易笔数',
		other_06 decimal COMMIT '最近1天的日均&Transtype.交易金额',
		other_07 FLOAT COMMIT '最近1天的&Transtype.交易金额占授信额度比例',
		other_08 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易笔数的比例',
		other_09 FLOAT COMMIT '最近1天与最近1天内的日均&Transtype.交易金额的比例',
		other_11 INTEGER COMMIT '最近3天&Transtype.交易笔数',
		other_12 DECIMAL(18,2) COMMIT '最近3天&Transtype.交易金额',
		other_13 DECIMAL(18,2) COMMIT '最近3天&Transtype.最大交易金额',
		other_14 INTEGER COMMIT '最近3天&Transtype.发生交易天数',
		other_15 INTEGER COMMIT '最近3天的日均&Transtype.交易笔数',
		other_16 DECIMAL(18,2) COMMIT '最近3天的日均&Transtype.交易金额',
		other_17 FLOAT COMMIT '最近3天的&Transtype.交易金额占授信额度比例',
		other_18 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易笔数的比例',
		other_19 FLOAT COMMIT '最近3天与最近3天内的日均&Transtype.交易金额的比例',
		other_20 STRING COMMIT '是否最近3天连续&Transtype.',
		other_21 STRING COMMIT '是否最近3天连续&Transtype.金额大于5万',
		other_22 STRING COMMIT '是否最近3天连续&Transtype.金额大于10万',
		other_23 STRING COMMIT '是否最近3天连续&Transtype.金额大于25万',
		other_24 STRING COMMIT '是否最近3天连续&Transtype.金额大于50万')
		WITH (
      'connector' = 'kafka',
      'topic' = 'qinghua_sink_table',
      'properties.group.id'='dev_flink',
      'properties.zookeeper.connect'='10.1.30.6:2181',
      'properties.bootstrap.servers' = '10.1.30.8:9092',
      'format' = 'json',
      'scan.startup.mode' = 'latest-offset'
      );

-- 注册函数
create function my_function as 'com.cebbank.airisk.flink.udfs.PreviousValueAggFunction$LongPreviousValueAggFunction';

-- 这个view的格式为
--  event_id       transtype        交易金额
create view mid_data_table_1 as
select
      event_id,
	  case
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '1%' then 'xiaofei'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '2%' then 'bangong'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '3%' then 'xinzi'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '4%' then 'baoxian'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '5%' then 'touzi'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '6%' then 'rongzi'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '7%' then 'zhuanzhang'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '8%' then 'cunqu'
	  when my_function(payer_name,acct_num,currency_conv_type_cd,txn_cd,txn_amt,new_borrow_flage,biz_product_type_cd,txn_desc,new_account_chinessname) like '9%' then 'other'
	  end as transtype,
	  cast(txn_amt as decimal ) as amount,
	  cast(txn_cd as decimal ) as cd,
	  txn_dt as txn_dt,
	   et
	  from source_table_1;

-- todo 创建一个中间视图 4个字段
create view mid_data_table_2 as
select
    et,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.amount,0) xiaofei_amount,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.cd,0) xiaofei_cd,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.txn_dt,0) xiaofei_txn_dt,
    if(mid_data_table_1.transtype='bangong',mid_data_table_1.amount,0) bangong_amount,
    if(mid_data_table_1.transtype='bangong',mid_data_table_1.cd,0) bangong_cd,
    if(mid_data_table_1.transtype='bangong',mid_data_table_1.ctxn_dt,0) bangong_txn_dt,
    if(mid_data_table_1.transtype='xinzi',mid_data_table_1.amount,0) xinzi_amount,
    if(mid_data_table_1.transtype='xinzi',mid_data_table_1.cd,0) xinzi_cd,
    if(mid_data_table_1.transtype='xinzi',mid_data_table_1.txn_dt,0) xinzi_txn_dt,
    if(mid_data_table_1.transtype='baoxian',mid_data_table_1.amount,0) baoxian_amount,
    if(mid_data_table_1.transtype='baoxian',mid_data_table_1.cd,0) baoxian_cd,
    if(mid_data_table_1.transtype='baoxian',mid_data_table_1.txn_dt,0) baoxian_txn_dt,
    if(mid_data_table_1.transtype='touzi',mid_data_table_1.amount,0) touzi_amount,
    if(mid_data_table_1.transtype='touzi',mid_data_table_1.cd,0) touzi_cd,
    if(mid_data_table_1.transtype='touzi',mid_data_table_1.txn_dt,0) touzi_txn_dt,
    if(mid_data_table_1.transtype='rongzi',mid_data_table_1.amount,0) rongzi_amount,
    if(mid_data_table_1.transtype='rongzi',mid_data_table_1.cd,0) rongzi_cd,
    if(mid_data_table_1.transtype='rongzi',mid_data_table_1.txn_dt,0) rongzi_txn_dt,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.amount,0) xiaofei_amount,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.cd,0) xiaofei_cd,
    if(mid_data_table_1.transtype='xiaofei',mid_data_table_1.txn_dt,0) xiaofei_txn_dt,
    if(mid_data_table_1.transtype='zhuanzhang',mid_data_table_1.amount,0) zhuanzhang_amount,
    if(mid_data_table_1.transtype='zhuanzhang',mid_data_table_1.cd,0) zhuanzhang_cd,
    if(mid_data_table_1.transtype='zhuanzhang',mid_data_table_1.txn_dt,0) zhuanzhang_txn_dt,
    if(mid_data_table_1.transtype='cunqu',mid_data_table_1.amount,0) cunqu_amount,
    if(mid_data_table_1.transtype='cunqu',mid_data_table_1.cd,0) cunqu_cd,
    if(mid_data_table_1.transtype='cunqu',mid_data_table_1.txn_dt,0) cunqu_txn_dt,
    if(mid_data_table_1.transtype='other',mid_data_table_1.amount,0) other_amount,
    if(mid_data_table_1.transtype='other',mid_data_table_1.cd,0) other_cd
    if(mid_data_table_1.transtype='other',mid_data_table_1.txn_dt,0) other_txn_dt
from mid_data_table_1;





--todo 创建1天的视图
select
        -- 消费相关
        sum(if xiaofei_amount!=0,1,0) over w xiaofei_01,
        sum(xiaofei_amount) over w xiaofei_02,
        max (xiaofei_amount) over w xiaofei_03,
        if(max (xiaofei_amount)!=0,1,0) over w xiaofei_04,
        sum(if xiaofei_amount!=0,1,0)/1 over w   xiaofei_05,
        sum(xiaofei_amount)/1  over w xiaofei_06,
        0.5                     xiaofei_07,    
        1                       xiaofei_08, 
        1                       xiaofei_09, 
        -- 办公相关
        sum(if bangong_amount!=0,1,0) over w bangong_01,
        sum(bangong_amount) over w bangong_02,
        max (bangong_amount)over w bangong_03,
        if(max (bangong_amount)!=0,1,0) over w bangong_04,
        sum(if bangong_amount!=0,1,0)/1 over w  bangong_05,
        sum(bangong_amount)/1 over w bangong_06,
        0.5                     bangong_07,    
        1                       bangong_08, 
        1                       bangong_09, 
        --薪资相关
        sum(if xinzi_amount!=0,1,0) over w xinzi_01,
        sum(xinzi_amount)over w xinzi_02,
        max (xinzi_amount)over w xinzi_03,
        if(max (xinzi_amount)!=0,1,0)over w xinzi_04,
        sum(if xinzi_amount!=0,1,0)/1 over w  xinzi_05,
        sum(xinzi_amount)/1 over w xinzi_06,
        0.5                     xinzi_07,    
        1                       xinzi_08, 
        1                       xinzi_09, 
        --保险相关
        sum(if baoxian_amount!=0,1,0) over w baoxian_01,
        sum(baoxian_amount)over w baoxian_02,
        max (baoxian_amount)over w baoxian_03,
        if(max (baoxian_amount)!=0,1,0)over w baoxian_04,
        sum(if baoxian_amount!=0,1,0)/1 over w  baoxian_05,
        sum(baoxian_amount)/1 over w baoxian_06,
        0.5                     baoxian_07,    
        1                       baoxian_08, 
        1                       baoxian_09,     
        --投资相关
        sum(if touzi_amount!=0,1,0) over w touzi_01,
        sum(touzi_amount)over w touzi_02,
        max (touzi_amount)over w touzi_03,
        if(max (touzi_amount)!=0,1,0)over w touzi_04,
        sum(if touzi_amount!=0,1,0)/1 over w  touzi_05,
        sum(touzi_amount)/1 over w  touzi_06,
        0.5                     touzi_07,    
        1                       touzi_08, 
        1                       touzi_09,     
        -- 融资相关
        sum(if rongzi_amount!=0,1,0) over w rongzi_01,
        sum(rongzi_amount) over w rongzi_02,
        max (rongzi_amount) over w rongzi_03,
        if(max (rongzi_amount)!=0,1,0)over w  rongzi_04,
        sum(if rongzi_amount!=0,1,0)/1 over w  rongzi_05,
        sum(rongzi_amount)/1 over w rongzi_06,
        0.5                     rongzi_07,    
        1                       rongzi_08, 
        1                       rongzi_09,     
        -- 转账相关
        sum(if zhuanzhang_amount!=0,1,0) over w zhuanzhang_01,
        sum(zhuanzhang_amount)over w zhuanzhang_02,
        max (zhuanzhang_amount)over w zhuanzhang_03,
        if(max (zhuanzhang_amount)!=0,1,0)over w zhuanzhang_04,
        sum(if zhuanzhang_amount!=0,1,0)/1 over w  zhuanzhang_05,
        sum(zhuanzhang_amount)/1 over w zhuanzhang_06,
        0.5                     zhuanzhang_07,    
        1                       zhuanzhang_08, 
        1                       zhuanzhang_09,     
        -- 存取相关
        sum(if cunqu_amount!=0,1,0) over w cunqu_01,
        sum(cunqu_amount) over w cunqu_02,
        max (cunqu_amount) over w cunqu_03,
        if(max (cunqu_amount)!=0,1,0)over w cunqu_04,
        sum(if cunqu_amount!=0,1,0)/1 over w  cunqu_05,
        sum(cunqu_amount)/1 over w cunqu_06,
        0.5                     cunqu_07,    
        1                       cunqu_08, 
        1                       cunqu_09,     
        -- 其他相关
        sum(if other_amount!=0,1,0) over w other_01,
        sum(other_amount) over w other_02,
        max (other_amount) over w other_03,
        if(max (other_amount)!=0,1,0) over w other_04,
        sum(if other_amount!=0,1,0)/1 over w  other_05,
        sum(other_amount)/1 over w other_06,
        0.5                     other_07,    
        1                       other_08, 
        1                       other_09     
from mid_data_table_2
WINDOW w AS (PARTITION BY ttype order by et RANGE BETWEEN INTERVAL '1' DAY preceding AND CURRENT ROW);





--todo 创建3天的视图
select
        et,
-- 消费相关
        sum(if xiaofei_amount!=0,1,0) over w xiaofei_10,
        sum(xiaofei_amount) over w xiaofei_11,
        max (xiaofei_amount) over w xiaofei_12,
        count(distinct day(xiaofei_txn_dt)) over w xiaofei_13,
        sum(if xiaofei_amount!=0,1,0)/3 over w   xiaofei_14,
        sum(xiaofei_amount)/3  over w xiaofei_15,
        0.5                     xiaofei_16,
        3 xiaofei_17,
        3 xiaofei_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') xiaofei_19,
-- 办公相关
        sum(if bangong_amount!=0,1,0) over w bangong_10,
        sum(bangong_amount) over w bangong_11,
        max (bangong_amount) over w bangong_12,
        count(distinct day(bangong_txn_dt)) over w bangong_13,
        sum(if bangong_amount!=0,1,0)/3 over w   bangong_14,
        sum(bangong_amount)/3  over w bangong_15,
        0.5                     bangong_16,
        3 bangong_17,
        3 bangong_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') bangong_19,
--薪资相关
        sum(if rongzi_amount!=0,1,0) over w rongzi_10,
        sum(rongzi_amount) over w rongzi_11,
        max (rongzi_amount) over w rongzi_12,
        count(distinct day(rongzi_txn_dt)) over w rongzi_13,
        sum(if rongzi_amount!=0,1,0)/3 over w   rongzi_14,
        sum(rongzi_amount)/3  over w rongzi_15,
        0.5                     rongzi_16,
        3 rongzi_17,
        3 rongzi_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') rongzi_19,
--保险相关
        sum(if baoxian_amount!=0,1,0) over w baoxian_10,
        sum(baoxian_amount) over w baoxian_11,
        max (baoxian_amount) over w baoxian_12,
        count(distinct day(baoxian_txn_dt)) over w baoxian_13,
        sum(if baoxian_amount!=0,1,0)/3 over w   baoxian_14,
        sum(baoxian_amount)/3  over w baoxian_15,
        0.5                     baoxian_16,
        3 baoxian_17,
        3 baoxian_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') baoxian_19,
--投资相关
        sum(if touzi_amount!=0,1,0) over w touzi_10,
        sum(touzi_amount) over w touzi_11,
        max (touzi_amount) over w touzi_12,
        count(distinct day(touzi_txn_dt)) over w touzi_13,
        sum(if touzi_amount!=0,1,0)/3 over w   touzi_14,
        sum(touzi_amount)/3  over w touzi_15,
        0.5                     touzi_16,
        3 touzi_17,
        3 touzi_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') touzi_19,
--融资相关
        sum(if rongzi_amount!=0,1,0) over w rongzi_10,
        sum(rongzi_amount) over w rongzi_11,
        max (rongzi_amount) over w rongzi_12,
        count(distinct day(rongzi_txn_dt)) over w rongzi_13,
        sum(if rongzi_amount!=0,1,0)/3 over w   rongzi_14,
        sum(rongzi_amount)/3  over w rongzi_15,
        0.5                     rongzi_16,
        3 rongzi_17,
        3 rongzi_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') rongzi_19,
-- 转账相关
        sum(if zhuanzhang_amount!=0,1,0) over w zhuanzhang_10,
        sum(zhuanzhang_amount) over w zhuanzhang_11,
        max (zhuanzhang_amount) over w zhuanzhang_12,
        count(distinct day(zhuanzhang_txn_dt)) over w zhuanzhang_13,
        sum(if zhuanzhang_amount!=0,1,0)/3 over w   zhuanzhang_14,
        sum(zhuanzhang_amount)/3  over w zhuanzhang_15,
        0.5                     zhuanzhang_16,
        3 zhuanzhang_17,
        3 zhuanzhang_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') zhuanzhang_19,
-- 存取相关
        sum(if cunqu_amount!=0,1,0) over w cunqu_10,
        sum(cunqu_amount) over w cunqu_11,
        max (cunqu_amount) over w cunqu_12,
        count(distinct day(cunqu_txn_dt)) over w cunqu_13,
        sum(if cunqu_amount!=0,1,0)/3 over w   cunqu_14,
        sum(cunqu_amount)/3  over w cunqu_15,
        0.5                     cunqu_16,
        3 cunqu_17,
        3 cunqu_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') cunqu_19,
-- 其他相关
        sum(if other_amount!=0,1,0) over w other_10,
        sum(other_amount) over w other_11,
        max (other_amount) over w other_12,
        count(distinct day(other_txn_dt)) over w other_13,
        sum(if other_amount!=0,1,0)/3 over w   other_14,
        sum(other_amount)/3  over w other_15,
        0.5                     other_16,
        3 other_17,
        3 other_18,
        if(count(distinct day(txn_dt)) over w =3,'是','否') other_19
from mid_data_table_2
WINDOW w AS (PARTITION BY ttype order by et RANGE BETWEEN INTERVAL '3' DAY preceding AND CURRENT ROW);



