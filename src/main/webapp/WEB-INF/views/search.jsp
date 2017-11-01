<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/24
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传下载</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/datepicker/WdatePicker.js"></script>
    <script type="text/javascript">
        $(function () {
            search();
        });
        function upload() {
            var orgId = $('input[name="orgId"]').val();
            var fileMonth = $('input[name="fileMonth"]').val();
            if (!(orgId && fileMonth)) {
                alert("单位和年月不能为空！");
                return;
            }
            $.ajax({
                url: "upload",
                type: 'POST',
                cache: false,
                data: new FormData($('#file-form')[0]),
                processData: false,
                contentType: false,
                dataType: "json",
                beforeSend: function () {
                    // uploading = true;
                },
                success: function (data) {
                    console.log(data);
                }
            });
        }
        function search() {
            var orgList = JSON.parse($.ajax({url:"getOrgList",async:false}).responseText);
            $('#dg').datagrid({
                url:'findRecords',
                method:'POST',
                queryParams: {
                    orgId: $("#orgIdSearch").combobox("getValue"),
                    fileMonth: $("#fileMonthSearch").val()
                },
                columns:[[
                    {field:'orgId',title:'单位',width:150,
                        formatter: function(value,row,index){
                            var result = "";
                            $.each(orgList, function(i, v) {
                                if (v.orgId == value) {
                                    result = v.orgName;
                                    return false;
                                }
                            });
                            return result;
                        }},
                    {field:'fileMonth',title:'年月',width:100},
                    {field:'filePath',title:'文件',width:500,
                        formatter: function(value,row,index){
                            var fileName = value.substring(value.lastIndexOf("/") + 1);
                            return "<a href='${pageContext.request.contextPath}"+value+"'>"+fileName+"</a>";
                    }}
                ]]
            });
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'center',iconCls:'icon-search',title:'查询'">
    <div>
        <label>单位</label>
        <input class="easyui-combobox"
               id="orgIdSearch"
               data-options="
          url:'getOrgList',
          method:'get',
          valueField:'orgId',
          textField:'orgName',
          panelHeight:'auto'
        ">
        <label>年月</label>
        <input class="Wdate" type="text" id="fileMonthSearch" onclick="WdatePicker({readOnly:true,dateFmt:'yyyyMM'})"/>
        <a href="javascript:search();void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    </div>
    <table id="dg"></table>
</div>
<div data-options="region:'south',border:false" class="south">
    <form id="file-form" method="post" enctype="multipart/form-data">
        <label>单位</label>
        <input class="easyui-combobox"
               name="orgId"
               data-options="
               url:'getOrgList',
               method:'get',
               valueField:'orgId',
               textField:'orgName',
               panelHeight:'auto'
        ">
        <label>年月</label>
        <input class="Wdate" type="text" name="fileMonth" onclick="WdatePicker({readOnly:true,dateFmt:'yyyyMM'})"/>
        <input class="easyui-filebox file-box" name="file" data-options="prompt:'选择Excel文件......'">
        <a href="javascript:void(0)" class="easyui-linkbutton submit-btn" onclick="upload()">Submit</a>
    </form>
</div>
</body>
</html>