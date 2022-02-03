public class OrderCheckHelper {
	public static void shippedCheck(List<Order> orderList) 
    {
        for(Order order: orderList)
        {
			if(order.Status == 'Processed' || order.Status == 'Delivered')
            {
                order.addError('Order cannot be canceled');
            }
		}
    }
}