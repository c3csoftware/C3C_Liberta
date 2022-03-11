public abstract class C3C_AbstractMapper 
{
    public abstract String getObjectName();

    public SObject record
    {
        get
        {
            if(this.record == null)
                this.record = Schema.getGlobalDescribe().get(this.getObjectName()).newSObject();

            return this.record;
        }
        set;
    }
    
	private Boolean buildingMapper 
    {
        get
        {
            if(this.buildingMapper == null)
                this.buildingMapper = false;
            return this.buildingMapper;
        }
        set;
    }
    
    public void setValueInRecord(String fieldName, Object value)
    {
        if(!this.buildingMapper)
            this.record.put(fieldName, value);
    }
    
    public void initBuild()
    {
        this.buildingMapper = true;
    }
    public void finishBuild()
    {
        this.buildingMapper = false;
    }
}