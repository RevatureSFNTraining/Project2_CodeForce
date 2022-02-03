import { track, LightningElement, wire, api } from 'lwc';

//Mohamed - This is a Product Detials component that displays details of a specific product once clicked (from the product list page) - this Component works in coordination with Sean's ProductList Aura component. 

// Ligthning Message Service and a message channel
import { CurrentPageReference, NavigationMixin } from 'lightning/navigation';


// Utils to extract field values
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

// Product__c Schema
import NAME_FIELD from '@salesforce/schema/Product2.Name';
import PRODUCT_CODE_FIELD from '@salesforce/schema/Product2.ProductCode';
import PRICE_FIELD from '@salesforce/schema/Product2.Price__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Product2.Description';
import PICTURE_URL_FIELD from '@salesforce/schema/Product2.DisplayURL__c';


//product fields 
const productFields = [NAME_FIELD, DESCRIPTION_FIELD, PICTURE_URL_FIELD, PRICE_FIELD, PRODUCT_CODE_FIELD]; 

/**
 * Component to display details of a Product__c.
 */
export default class ProductDetails extends NavigationMixin(LightningElement) {
    @track displayValue;
    @api recordId;
    // Exposing fields to make them available in the template

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
    if (currentPageReference) {
        const urlValue = currentPageReference.state.c__recordId;
        if (urlValue) {
            this.displayValue = `${urlValue}`;
            this.recordId = this.displayValue;
        } else {
            this.displayValue = `URL Value was not set`;
        }
    }
    }

    //default quantity
    qty = 1;

    //using wire to access record fields
    
    @wire(getRecord, {recordId: '$recordId', fields: productFields})
    Product2; 

    //get name method
    get productName(){
        return getFieldValue(this.Product2.data, NAME_FIELD); 
    }

    //git Product2 picture method
    get productPictureUrl(){
        return getFieldValue(this.Product2.data, PICTURE_URL_FIELD); 
    }

    //get Product2 price method
    get price(){
        return getFieldValue(this.Product2.data, PRICE_FIELD); 
    }

    //get Product2 discription 
    get description(){
        return getFieldValue(this.Product2.data, DESCRIPTION_FIELD);
    }

    //set Defualt quantity method
    set defaultQuantity(value) {
        this.qty = value;
    }

    //handle change of quantity
    handleChange(event) {
        this.qty = event.target.value;
    }

    //calculate total price method
    get totalPrice() {
        return this.qty * getFieldValue(this.Product2.data, PRICE_FIELD); 
    }

    /**
     * Handler for when a Product2 is selected. When `this.recordId` changes, the
     * lightning-record-view-form component will detect the change and provision new data.
     */
    handleProductSelected(productId) {
        this.recordId = productId;
    }
}