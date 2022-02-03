//Andrew Trans Component
//Adds a new product to the database with all the required fields

import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import CONTACT_OBJECT from '@salesforce/schema/Product2';
import productName from '@salesforce/schema/Product2.Name';
import productPrice from '@salesforce/schema/Product2.Price__c';
import productUrlName from '@salesforce/schema/Product2.DisplayURL__c';
import accountFieldId from '@salesforce/schema/Product2.Manufacturer__c';

export default class LwcCreateContactCustomLookup extends NavigationMixin(LightningElement) {   

    @track isModalOpen = false;
    @track selectedAccountId;
    @track contactId;    
    productname = '';
    productprice = '';   
    url = '';

    openModal() {
        // to open modal set isModalOpen track value as true
        this.isModalOpen = true;
    }
    closeModal() {
            // to close modal set isModalOpen track value as false
        this.isModalOpen = false;
    }

    // Handles all input and button actions
    contactHandleChange(event) {
        console.log(event.target.label);
        console.log(event.target.value);        
        if(event.target.label=='Product Name'){
            this.productname = event.target.value;
        }
        if(event.target.label=='Product Price'){
            this.productprice = event.target.value;
        }   
        if(event.target.label=='Product URL'){
            this.url = event.target.value;
        }          
    }

    // Handles the submit action of the button by creating a new product if successful
    createLookupContactAction(){
        console.log(this.selectedAccountId);
        const fields = {};
        fields[productName.fieldApiName] = this.productname;
        fields[productPrice.fieldApiName] = this.productprice;
        fields[productUrlName.fieldApiName] = this.url;
        fields[accountFieldId.fieldApiName] = this.selectedAccountId;
        const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(contactobj=> {
                this.contactId = contactobj.id;
                this.fields={};
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Product created successfully..!',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
        this.isModalOpen = false;
    }
    myLookupHandle(event){
        console.log(event.detail);
        this.selectedAccountId = event.detail;
    }

}