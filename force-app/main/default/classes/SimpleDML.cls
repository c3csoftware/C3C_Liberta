public virtual class SimpleDML implements fflib_SObjectUnitOfWork.IDML
{
    public virtual void dmlInsert(List<SObject> objList)
    {
        insert objList;
    }
    public virtual void dmlUpdate(List<SObject> objList)
    {
        update objList;
    }
    public virtual void dmlUpsertUsingExternalId(List<SObject> objList, String objectName,String externalIdField)
    {
        Map<String,Schema.SObjectField> mfields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();

        Database.upsert(objList, mfields.get(externalIdField), true);
    }
    public virtual void dmlDelete(List<SObject> objList)
    {
        delete objList;
    }
    public virtual void eventPublish(List<SObject> objList)
    {
        EventBus.publish(objList);
    }
    public virtual void emptyRecycleBin(List<SObject> objList)
    {
        if (objList.isEmpty())
        {
            return;
        }

        Database.emptyRecycleBin(objList);
    }
}