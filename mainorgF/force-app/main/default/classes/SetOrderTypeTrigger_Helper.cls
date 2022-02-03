public with sharing class SetOrderTypeTrigger_Helper {
    public static void SetOrderTypeTrigger_Helper(List<OrderItem> itemList) {
        list <order> orderlist=new list <order>();
        for (OrderItem o : itemList) {      
            Order dsd = [SELECT Name, TotalAmount FROM Order WHERE id=:o.OrderId];
            if (dsd.TotalAmount >= 10000) {
                dsd.Type = 'Bulk';
                orderlist.add(dsd);
            }
        else {
            dsd.Type = 'Small';
            orderlist.add(dsd);
            }
        }
        update orderlist;
    }
}