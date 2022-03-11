import { LightningElement, track, api } from 'lwc';
import findRecords from '@salesforce/apex/CustomLookupLWCComponentController.findRecords';

export default class CustomLookup extends LightningElement {
    @track records;
    @track error;
    @track selectedRecord;
    @track valueFieldSearch = '';

    @api labelInput;
    @api disabled = false;
    @api disableRemove = false;
    @api notDisabled = false;

    @api name;
    @api index;
    @api relationshipfield;
    @api iconname = "custom:custom57";
    @api objectName = 'Campaign';
    @api fields;
    @api searchfield = 'Name';
    @api searchfields = [];
    @api fieldLabel = 'Name';
    @api where = '';
    @api formFields = ['Name', 'Type', 'RecordTypeId'];

    @api limitSearch = 5;
    @api selectedId;

    @api createEnabled = false;
    createNew = false;

    initComponent() 
    {
        if(this.searchfields.length == 0)
            this.searchfields.push(this.searchfield);

        if (this.selectedId !== undefined)
        {
            this.records = undefined;
            let searchKey = '';

            let functionCallBack = (result) => 
            {
                this.records = result;

                for (let i = 0; i < this.records.length; i++) {
                    let rec = this.records[i];
                    this.records[i][this.fieldLabel] = rec[this.fieldLabel];
                }
                this.error = undefined;

                this.selectedRecord = this.records.find(record => record.Id === this.selectedId);
                this.valueFieldSearch = this.selectedRecord[this.fieldLabel];

                let selectedRecordEvent = new CustomEvent(
                    "selectedrec", {
                        detail: {
                            recordId: this.selectedId,
                            record: this.selectedRecord,
                            index: this.index,
                            relationshipfield: this.relationshipfield,
                            target: this.name
                        }
                    }
                );
                if (!this.notDisabled) {
                    this.disabled = true;
                    this.disableRemove = true;
                }
                this.dispatchEvent(selectedRecordEvent);
            }

            let functionError = (error) => 
            {
                this.error = error;
                this.records = undefined;
                console.log(error);
            }

            findRecords({
                    searchKey: searchKey,
                    objectName: this.objectName,
                    fields: this.fields,
                    searchField: this.searchfield,
                    limitSearch: this.limitSearch,
                    whereSearch: 'AND Id = \'' + this.selectedId + '\' '
                })
                .then(functionCallBack)
                .catch(functionError);
        }
    }

    connectedCallback() 
    {
        this.initComponent();
    }

    handleOnchange(event) 
    {
        if (this.selectedId != undefined)
            return;

        let searchKey = event.detail.value;

        if(searchKey == undefined)
            searchKey = '';

        let functionCallBack = (result) => 
        {
            this.records = result;
            for (let i = 0; i < this.records.length; i++) {
                let rec = this.records[i];
                this.records[i][this.fieldLabel] = rec[this.fieldLabel];
            }
            this.error = undefined;

            if (this.records == undefined)
                this.records = [];
        }

        let functionError = (error) => 
        {
            this.error = error;
            this.records = [];
            console.log(error);
        }

        findRecords({
                searchKey: searchKey,
                objectName: this.objectName,
                fields: this.fields,
                searchFields: this.searchfields,
                limitSearch: this.limitSearch,
                whereSearch: this.where
            })
            .then(functionCallBack)
            .catch(functionError);
    }
    handleSelect(event) {

        if (event.detail == 'createNew') 
        {
            this.createNew = !this.createNew;
            this.dispatchEvent(new CustomEvent(
                'selectedrec', {
                    detail: { recordId: event.detail, target: this.name }
                }
            ));

            return;
        }

        this.createNew = false;

        let selectedRecordId = event.detail;
        this.selectedRecord = this.records.find(record => record.Id === selectedRecordId);
        this.valueFieldSearch = this.selectedRecord[this.fieldLabel];

        let selectedRecordEvent = new CustomEvent(
            "selectedrec", {
                detail: {
                    recordId: selectedRecordId,
                    record: this.selectedRecord,
                    index: this.index,
                    relationshipfield: this.relationshipfield,
                    target: this.name
                }
            }
        );
        this.dispatchEvent(selectedRecordEvent);
    }

    handleRemove(event) 
    {
        event.preventDefault();
        this.selectedRecord = undefined;
        this.records = undefined;
        this.error = undefined;
        this.selectedId = undefined;

        let selectedRecordEvent = new CustomEvent(
            "selectedrec", {
                detail: { recordId: undefined, index: this.index, relationshipfield: this.relationshipfield }
            }
        );
        this.dispatchEvent(selectedRecordEvent);
    }

    handleSuccess(event) 
    {

        this.selectedId = event.detail.id;
        this.createNew = !this.createNew;
        this.initComponent();
    }

    handleCancel(event) 
    {
        this.createNew = !this.createNew;
    }

    btnCloseOnClick(event) 
    {
        this.createNew = !this.createNew;
    }

    //Conditions

    get conditionViewItems() 
    {
        return this.records != undefined && (this.records.length > 0 || this.createEnabled) && this.selectedRecord == undefined;
    }
}