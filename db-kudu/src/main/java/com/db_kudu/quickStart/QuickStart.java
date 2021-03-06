package com.db_kudu.quickStart;

import org.apache.kudu.ColumnSchema;
import org.apache.kudu.Schema;
import org.apache.kudu.Type;
import org.apache.kudu.client.*;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;

public class QuickStart {
    //声明全局变量 KuduClient 后期通过它来操作 kudu 表
    private KuduClient kuduClient;
    //指定 kuduMaster 地址
    private String kuduMaster;
    //指定表名
    private String tableName;

    @Before
    public void init() {
        //初始化操作
        kuduMaster = "real-time-006";
        //指定表名
        tableName = "qinghua_finicalinfo";
        KuduClient.KuduClientBuilder kuduClientBuilder = new KuduClient.KuduClientBuilder(kuduMaster);
        kuduClientBuilder.defaultSocketReadTimeoutMs(10000);
        kuduClient = kuduClientBuilder.build();
    }

    /**
     * 创建表
     */
    @Test
    public void createTable() throws KuduException {
        //判断表是否存在，不存在就构建
        if (!kuduClient.tableExists(tableName)) {
            //构建创建表的 schema 信息-----就是表的字段和类型
            ArrayList<ColumnSchema> columnSchemas = new ArrayList<ColumnSchema>();
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("relation_id",Type.STRING).key(true).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("event_type",Type.STRING).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("user_id",Type.STRING).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("amt",Type.FLOAT).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("event_dt",Type.INT64).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("should_repay_time",Type.INT64).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("repay_state",Type.STRING).build());
            columnSchemas.add(new ColumnSchema.ColumnSchemaBuilder("actual_repay_time",Type.INT64).build());
            Schema schema = new Schema(columnSchemas);
            //指定创建表的相关属性
            CreateTableOptions options = new CreateTableOptions();
            ArrayList<String> partitionList = new ArrayList<String>();
            //指定 kudu 表的分区字段是什么
            partitionList.add("relation_id"); // 按照 id.hashcode % 分区数 = 分区号
            options.addHashPartitions(partitionList, 6);
            kuduClient.createTable(tableName, schema, options);
        }
    }

    /**
     * 向表加载数据
     */
    @Test
    public void insertTable() throws KuduException {
        //向表加载数据需要一个 kuduSession 对象
        KuduSession kuduSession = kuduClient.newSession();
        kuduSession.setFlushMode(SessionConfiguration.FlushMode.AUTO_FLUSH_SYNC);
        //需要使用 kuduTable 来构建 Operation 的子类实例对象
        KuduTable kuduTable = kuduClient.openTable(tableName);
        for (int i = 1; i <= 10000; i++) {
            Insert insert = kuduTable.newInsert();
            PartialRow row = insert.getRow();
            row.addInt("id", i);
            row.addInt("money", i);
            kuduSession.apply(insert);//最后实现执行数据的加载操作
        }
    }

    /**
     * 查询表的数据结果
     */
    @Test
    public void queryData() throws KuduException {
        //构建一个查询的扫描器
        KuduScanner.KuduScannerBuilder kuduScannerBuilder =
                kuduClient.newScannerBuilder(kuduClient.openTable(tableName));
        ArrayList<String> columnsList = new ArrayList<String>();
        columnsList.add("id");
        columnsList.add("name");
        columnsList.add("age");
        columnsList.add("sex");
        kuduScannerBuilder.setProjectedColumnNames(columnsList);
        //返回结果集
        KuduScanner kuduScanner = kuduScannerBuilder.build();
        //遍历
        while (kuduScanner.hasMoreRows()) {
            RowResultIterator rowResults = kuduScanner.nextRows();
            while (rowResults.hasNext()) {
                RowResult row = rowResults.next();
                int id = row.getInt("id");
                String name = row.getString("name");
                int age = row.getInt("age");
                int sex = row.getInt("sex");
                System.out.println("id=" + id + " name=" + name + " age=" + age + " sex=" + sex);
            }
        }
    }

    /**
     * 修改表的数据
     */
    @Test
    public void updateData() throws KuduException {
        //修改表的数据需要一个 kuduSession 对象
        KuduSession kuduSession = kuduClient.newSession();
        kuduSession.setFlushMode(SessionConfiguration.FlushMode.AUTO_FLUSH_SYNC);
        //需要使用 kuduTable 来构建 Operation 的子类实例对象
        KuduTable kuduTable = kuduClient.openTable(tableName);
        //Update update = kuduTable.newUpdate();
        Upsert upsert = kuduTable.newUpsert(); //如果 id 存在就表示修改，不存在就新增
        PartialRow row = upsert.getRow();
        row.addInt("id", 100);
        row.addString("name", "zhangsan-100");
        row.addInt("age", 100);
        row.addInt("sex", 0);
        kuduSession.apply(upsert);//最后实现执行数据的修改操作
    }

    /**
     * 删除数据
     */
    @Test
    public void deleteData() throws KuduException {
        //删除表的数据需要一个 kuduSession 对象
        KuduSession kuduSession = kuduClient.newSession();
        kuduSession.setFlushMode(SessionConfiguration.FlushMode.AUTO_FLUSH_SYNC);
        //需要使用 kuduTable 来构建 Operation 的子类实例对象
        KuduTable kuduTable = kuduClient.openTable(tableName);
        Delete delete = kuduTable.newDelete();
        PartialRow row = delete.getRow();
        row.addInt("id", 100);
        kuduSession.apply(delete);//最后实现执行数据的删除操作
    }

    @Test
    public void dropTable() throws KuduException {
        if (kuduClient.tableExists(tableName)) {
            kuduClient.deleteTable(tableName);
        }
    }
}
