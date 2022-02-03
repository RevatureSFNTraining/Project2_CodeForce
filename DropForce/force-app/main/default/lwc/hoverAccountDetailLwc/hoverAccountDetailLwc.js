import { track, api, wire, LightningElement } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import MAIN_MARKET_FIELD from '@salesforce/schema/Account.Main_Market__c';
import NUMBER_LOCATIONS_FIELD from '@salesforce/schema/Account.NumberofLocations__c';
import YEAR_STARTED_FIELD from '@salesforce/schema/Account.YearStarted';
import CERTIFICATIONS_FIELD from '@salesforce/schema/Account.Certifications__c';

export default class HoverObjectDetailLwc extends NavigationMixin (LightningElement) {
    @api recordDisplayId;
    @track CurrentPageReference;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }
    get recordId() {
        return this.currentPageReference?.state?.c__recordId;
    }

    url;
    url;

    connectedCallback() {
        // Store the PageReference in a variable to use in handleClick.
        // This is a plain Javascript object that conforms to the
        // PageReference type by including 'type' and 'attributes' properties.
        // The 'state' property is optional.
        this.accountHomePageRef = {
            type: 'comm__namedPage',
            attributes: {
                name: 'Supplier_Info__c'
            },
            state: {
                c__recordId: '01t8c00000HE0JYAA1',
            }
        };
        this[NavigationMixin.GenerateUrl](this.accountHomePageRef)
            .then(url => this.url = url);
    }

    handleClick(evt) {
        // Stop the event's default behavior.
        // Stop the event from bubbling up in the DOM.
        evt.preventDefault();
        evt.stopPropagation();
        // Navigate to the Account Home page.
        this[NavigationMixin.Navigate](this.accountHomePageRef);
    }

    // Variable to receive Record Id from Parent Aura Component

    
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
