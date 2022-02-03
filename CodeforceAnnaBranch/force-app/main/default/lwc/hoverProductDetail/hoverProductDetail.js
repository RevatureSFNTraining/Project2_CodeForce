import { track, api, wire, LightningElement } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';
import NAME_FIELD from '@salesforce/schema/Product2.Name';
import PRICE_FIELD from '@salesforce/schema/Product2.Price__c';
import FAMILY_FIELD from '@salesforce/schema/Product2.Family';

export default class HoverObjectDetailLwc extends NavigationMixin (LightningElement) {
    @api recordDisplayId;

    @wire(getRecord, 
        {
            recordId: '$recordDisplayId', 
            fields: [NAME_FIELD, PRICE_FIELD, FAMILY_FIELD]
        }) product2;

    @track CurrentPageReference;
    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
    }
    get recordId() {
        return this.currentPageReference?.state?.c__recordId;
    }

    url;

    connectedCallback() {
        // Store the PageReference in a variable to use in handleClick.
        // This is a plain Javascript object that conforms to the
        // PageReference type by including 'type' and 'attributes' properties.
        // The 'state' property is optional.
        this.accountHomePageRef = {
            type: 'comm__namedPage',
            attributes: {
                name: 'product_detail__c',
            },
            state: {
                c__recordId: this.recordDisplayId,
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