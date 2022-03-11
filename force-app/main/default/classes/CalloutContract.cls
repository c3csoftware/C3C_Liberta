public abstract class CalloutContract 
{
    public CalloutConfigDomain configuration {get; set;}
    
    public CalloutContract(CalloutConfigDomain config)
    {
        this.configuration = config;
    }
    
    public virtual string getEndPoint()
    {
        return configuration.endPoint;
    }
    
    public virtual Integer getTimeout()
    {
        return integer.valueOf(configuration.timeout);
    }
    
    public virtual string getMethod()
    {        
        return configuration.method;
    }
    
    public virtual string getBody()
    {
    	return '';
    }
     
    public abstract Object getReturn(HttpResponse response);
    
    public virtual void setHeader(HttpRequest request)
    {
        request.setHeader('Content-Type','application/json;charset=utf-8');
    }
}