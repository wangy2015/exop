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
  <title>Excel在线编辑</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css">
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/cell-edit.js"></script>
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
  <div data-options="region:'west',split:true,title:'Excel'" class="west">
    <ul class="easyui-tree">
      <li>数据表格1.xls</li>
      <li>数据表格2.xls</li>
      <li>数据表格3.xls</li>
      <li>数据表格4.xls</li>
    </ul>
  </div>
  <div data-options="region:'center',iconCls:'icon-edit',title:'导入/编辑'">
    <table id="dg" style="width:100%;height:auto"
           data-options="
				singleSelect: true,
				url: 'datagrid_data1.json',
				method:'get'
			">
      <thead>
      <tr>
        <th data-options="field:'itemid',width:80">Item ID</th>
        <th data-options="field:'productid',width:100,editor:'text'">Product</th>
        <th data-options="field:'listprice',width:80,align:'right',editor:{type:'numberbox',options:{precision:1}}">List Price</th>
        <th data-options="field:'unitcost',width:80,align:'right',editor:'numberbox'">Unit Cost</th>
        <th data-options="field:'attr1',width:250,editor:'text'">Attribute</th>
        <th data-options="field:'status',width:60,align:'center',editor:{type:'checkbox',options:{on:'P',off:''}}">Status</th>
      </tr>
      </thead>
    </table>
  </div>
  <div data-options="region:'south',border:false" class="south">
    <form id="file-form" method="post" enctype="multipart/form-data">
      <input class="easyui-filebox file-box" name="file" data-options="prompt:'选择Excel文件......'">
      <a href="javascript:void(0)" class="easyui-linkbutton submit-btn" onclick="upload()">Submit</a>
    </form>
  </div>
</body>
</html>