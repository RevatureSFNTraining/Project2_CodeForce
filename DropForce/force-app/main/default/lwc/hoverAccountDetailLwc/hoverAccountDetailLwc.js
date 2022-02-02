import { api, wire, LightningElement } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import MAIN_MARKET_FIELD from '@salesforce/schema/Account.Main_Market__c';
import NUMBER_LOCATIONS_FIELD from '@salesforce/schema/Account.NumberofLocations__c';
import YEAR_STARTED_FIELD from '@salesforce/schema/Account.YearStarted';
import CERTIFICATIONS_FIELD from '@salesforce/schema/Account.Certifications__c';

export default class HoverObjectDetailLwc extends LightningElement {

    // Variable to receive Record Id from Parent Aura Component
    @api recordDisplayId;

    
    // Data Call to receive record information to Display
    @wire(getRecord, 
        {
            recordId: '$recordDisplayId', 
            fields: [NAME_FIELD, YEAR_STARTED_FIELD, MAIN_MARKET_FIELD, NUMBER_LOCATIONS_FIELD, CERTIFICATIONS_FIELD]
        }) account;

    // Getters to send record data to the markup
    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }
    get market() {
        return getFieldValue(this.account.data, MAIN_MARKET_FIELD);
    }
    get locations() {
        return getFieldValue(this.account.data, NUMBER_LOCATIONS_FIELD);
    }
    get year() {
        return getFieldValue(this.account.data, YEAR_STARTED_FIELD);
    }
    get certifications() {
        return getFieldValue(this.account.data, CERTIFICATIONS_FIELD);
    }

}