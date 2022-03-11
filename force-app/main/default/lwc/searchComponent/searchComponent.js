import { LightningElement, track, api } from 'lwc';

export default class SearchComponent extends LightningElement {
    @track searchKey;

    @api labelInput;
    @api disabled = false;

    handleChange(event){
        const searchKey = event.target.value;
        event.preventDefault();
        const searchEvent = new CustomEvent(
            'change', 
            { 
                detail : searchKey
            }
        );
        this.dispatchEvent(searchEvent);
    }
}