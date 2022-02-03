trigger OrderCheckTrigger on Order (before update, before delete) {
	Switch on Trigger.OperationType {
        when BEFORE_UPDATE{
            OrderCheckHelper.shippedCheck(Trigger.new);
        }
        when BEFORE_DELETE{
            OrderCheckHelper.shippedCheck(Trigger.new);
        }
    }
}