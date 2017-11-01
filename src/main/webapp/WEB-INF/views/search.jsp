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
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css">
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/cell-edit.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/datepicker/WdatePicker.js"></script>
  <script type="text/javascript">
    $(function(){
      $('#dg').datagrid().datagrid('enableCellEditing');
    })
    function upload() {
      $.ajax({
        url: "upload",
        type: 'POST',
        cache: false,
        data: new FormData($('#file-form')[0]),
        processData: false,
        contentType: false,
        dataType:"json",
        beforeSend: function(){
          // uploading = true;
        },
        success : function(data) {
          console.log(data);
        }
      });
    }
  </script>
</head>
<body class="easyui-layout">
  <div data-options="region:'center',iconCls:'icon-search',title:'查询'">
    <div>
      <label>单位</label>
      <input class="easyui-combobox"
        name="单位"
        data-options="
          url:'getOrgList',
          method:'get',
          valueField:'orgId',
          textField:'orgName',
          panelHeight:'auto'
        ">
      <label>年月</label>
      <input class="Wdate" type="text" id="d15" onclick="WdatePicker({readOnly:true,dateFmt:'yyyyMM'})"/>
      <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    </div>
  </div>
  <div data-options="region:'south',border:false" class="south">
    <form id="file-form" method="post" enctype="multipart/form-data">
      <input class="easyui-filebox file-box" name="file" data-options="prompt:'选择Excel文件......'">
      <a href="javascript:void(0)" class="easyui-linkbutton submit-btn" onclick="upload()">Submit</a>
    </form>
  </div>
</body>
</html>