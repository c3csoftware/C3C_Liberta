import { LightningElement, api } from 'lwc';

export default class RecordList extends LightningElement {
    @api record;
    @api fieldname;
    @api iconname;

    get fieldNameValue(){
        if(this.record == 'createNew')
            return 'Criar novo';

        return this.record[this.fieldname];
    } 

    handleSelect(event){
        event.preventDefault();
        const selectedRecord = new CustomEvent(
            "select",
            {
                detail : this.record == 'createNew' ? this.record : this.record.Id
            }
        );
        this.dispatchEvent(selectedRecord);
    }
}