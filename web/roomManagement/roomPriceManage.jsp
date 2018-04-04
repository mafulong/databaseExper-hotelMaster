<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ page import="entity.*" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.GCON" %>
<%@ page import="tool.Query" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map = request.getParameterMap() ;
        int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
%>

<head>
    <meta charset="UTF-8">
    <title>客房管理</title>
    <script>
        function returnMainPage() {
            window.location.href="/roomManagement/roomPriceManage.jsp?op=2";
        }

        function submitNewRoomInfo() {
            // console.log("tijiao")
            var roomnewprice = document.getElementById("newPrice").value;
            // alert(roomnewprice);
            var roomType = document.getElementById("roomType").value;
            var remarks = document.getElementById("remarks").value;
            var url = "&newPrice=" + roomnewprice + "&roomType=" + roomType + "&remarks=" + remarks;
            window.location.href = "/roomManagement/roomPriceManage.jsp?op=3" + url;
            return false ;
        }

        function ensureButtonClicked() {

            // var roomnumber = document.getElementById('roomNumber')
            // var roomtype= document.getElementById('roomType')

            var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
                + "&" + window.location.href.split("&")[3];

            window.location.href = "/roomManagement/roomPriceManage.jsp?op=4&" + urlNew;

        }
    </script>
</head>
<%@include file="/hotelAdmin.jsp"%>
<body>
    <%-- 后期换成session(\"name\")  --%>
    <div class="pusher">

        <div class="ui container">
            <h2 class="ui header">客房价格设置</h2>
            <div class="ui column grid">
                <div class="four wide column">
                    <div class="ui vertical steps">

                        <div class="<%=(op == 2) ? "active step ":"completed step"%>" >
                            <i class="add circle icon"></i>
                            <div class="content">
                                <div class="title">客房价格信息</div>
                            </div>
                        </div>

                        <div class="<%=(op == 3) ? "active step ":(op== 2)?"step":"completed step"%>">
                            <i class="check circle icon"></i>
                            <div class="content">
                                <div class="title">信息确认</div>
                            </div>
                        </div>

                    </div>

                </div>

                <div class="eleven wide  column" >

                    <%//改变价格信息
                        if (op == 2) {
                    %>
                    <form class="ui form" onsubmit="return submitNewRoomInfo(this)">
                        <h2 class="ui dividing header">填写新价格</h2>
                        <div class="two fields">

                            <div class="field">
                                <label>房间类型</label>
                                <% ArrayList<RoomTypeAndPrice> rooms = getAllRooms();%>
                                <select class="ui fluid dropdown" id="roomType">
                                    <%for(RoomTypeAndPrice room :rooms){%>
                                    <option value=<%=room.getRoomType()%>><%=room.getRoomType()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="field">
                                <label>新的价格</label>
                                <input type="text" id="newPrice" name="newprice" placeholder="输入新价格">
                            </div>
                        </div>
                        <div class="field">
                            <label>备注</label>
                            <input type="text" id="remarks" placeholder="备注信息">
                        </div>
                        <div class="ui submit button" onclick="return submitNewRoomInfo(this)">提交</div>
                    </form>

                    <%} else if (op == 3) {
                    %>

                    <h2 class="ui dividing header">待添加客房信息确认</h2>
                    <form class="ui form">
                        <table class="ui table">
                            <thead>
                            <tr><th class="six wide">房间类型</th>
                                <th class="six wide">房间价格</th>
                                <th class="six wide">备注</th>
                            </tr></thead>
                            <tbody>
                            <tr>
                                <td><%=request.getParameter("roomType")%></td>
                                <td><%=request.getParameter("newPrice")%>元</td>
                                <td><%=request.getParameter("remarks")%></td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="ui button" onclick="ensureButtonClicked()">确认</div>
                    </form>

                    <%} else if (op == 4) {
                        Query.updateRoomPrice(request.getParameter("roomType"),request.getParameter("newPrice"));;
                        System.out.println("价格更新了！！！"+request.getParameter("roomType")+request.getParameter("newPrice"));
                    %>
                    <h4 class="ui dividing header">添加成功</h4>
                    <div class="ui right button" onclick="returnMainPage()">返回</div>
                    <%}%>
                </div>
            </div>
        </div>

        <%--<h1>欢迎宾馆管理员登录！</h1>--%>

    </div>
</body>
</html>
