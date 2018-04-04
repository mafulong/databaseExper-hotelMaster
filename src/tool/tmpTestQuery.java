package tool;

import display.OrderView;

import java.util.ArrayList;


public class tmpTestQuery {
    public static void main(String[] args){
//        String roomtype="大床房(单人/双人)";
//        String newprice="187";
//        Query.updateRoomPrice(roomtype,newprice);
        ArrayList<OrderView> orderViews = Query.getAllOrderViews("已预定");
        System.out.println(orderViews.size());
        Query.getOrderNum();
    }
}
