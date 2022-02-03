trigger ProductTrigger on Product2 (after update) {

    Switch on Trigger.OperationType {
        when BEFORE_INSERT {
            
        } 
        when BEFORE_UPDATE {

        }
        when BEFORE_DELETE {

        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
			ProductTrigger_Helper.discontinued(Trigger.new);
        }
        when AFTER_DELETE {

        }
        when AFTER_UNDELETE {

        } 
    }
}