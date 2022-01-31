//importing elements to work with
import { LightningElement, track, api, wire } from 'lwc';
import { getRecord, getFieldValue} from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Product2.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Product2.description';
import PRODUCT_URL__C_FIELD from '@salesforce/schema/Product2.Product_URL__c';
import PRICE__C_FIELD from '@salesforce/schema/Product2.Price__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


//list of fields we're working with
const productFields = [NAME_FIELD, DESCRIPTION_FIELD, PRODUCT_URL__C_FIELD, PRICE__C_FIELD];

export default class AddToCart extends LightningElement {
    //creating our variables
    @api recordId = '01t8c00000IYaiuAAD';
    @api totalPrice = 7460;
    @api qty = 5;
    //accessing fields of the record we're working with
    @wire(getRecord, { recordId: '$recordId', fields: productFields })
    Product2;
    //message for toast alert
    message = "product has been added to cart!";

    //getters for our HTML components to display data
    get name(){
        return getFieldValue(this.Product2.data, NAME_FIELD);
    }

    //did not end up using the product description but kept it here in case we decide to use it
    //get description(){
    //    return getFieldValue(this.Product2.data, DESCRIPTION_FIELD);
    //}

    get productPictureURL(){
        return getFieldValue(this.Product2.data, PRODUCT_URL__C_FIELD);
    }

        //Boolean tracked variable to indicate if modal is open or not
    @track isModalOpen = false;
    
    openModal() {
        // to open modal set isModalOpen track value as true
        this.isModalOpen = true;
    }
    closeModal() {
            // to close modal set isModalOpen track value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen track value as false
        console.log("Item(s) successfully added to your cart");
        //calls the method to display a success message
        this.displayMessage();
        this.isModalOpen = false;
    }

    displayMessage() {
        //toast event to tell the user the items were added to their cart
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'Item(s) successfully added to your cart',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}