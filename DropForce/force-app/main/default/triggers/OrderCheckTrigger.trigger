trigger OrderCheckTrigger on Order (before insert) {
    Switch on Trigger.OperationType {
        when BEFORE_UPDATE{
            OrderCheckHelper.shippedCheck(Trigger.new);
        }
        when BEFORE_DELETE{
            OrderCheckHelper.shippedCheck(Trigger.new);
        }
    }
}