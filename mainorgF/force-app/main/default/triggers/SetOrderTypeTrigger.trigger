trigger SetOrderTypeTrigger on OrderItem (after insert, after update) {
    Switch on Trigger.OperationType {
         when BEFORE_INSERT {
           } 
           when BEFORE_UPDATE {
           }
           when BEFORE_DELETE {
           }
           when AFTER_INSERT {
               SetOrderTypeTrigger_Helper.SetOrderTypeTrigger_Helper(Trigger.new);
           }
           when AFTER_UPDATE {
               SetOrderTypeTrigger_Helper.SetOrderTypeTrigger_Helper(Trigger.new);
           }
           when AFTER_DELETE {
           }
           when AFTER_UNDELETE {
           } 
       }
   }