import { api, wire, LightningElement } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Product2.Name';
import PRICE_FIELD from '@salesforce/schema/Product2.Price__c';
import FAMILY_FIELD from '@salesforce/schema/Product2.Family';

export default class HoverObjectDetailLwc extends LightningElement {

    // Variable to receive Record Id from Parent Aura Component
    @api recordDisplayId;

    
    // Data Call to receive record information to Display
    @wire(getRecord, 
        {
            recordId: '$recordDisplayId', 
            fields: [NAME_FIELD, PRICE_FIELD, FAMILY_FIELD]
        }) product2;

    // Getters to send record data to the markup
    get name() {
        return getFieldValue(this.product2.data, NAME_FIELD);
    }
    get price() {
        return getFieldValue(this.product2.data, PRICE_FIELD);
    }
    get family() {
        return getFieldValue(this.product2.data, FAMILY_FIELD);
    }

}