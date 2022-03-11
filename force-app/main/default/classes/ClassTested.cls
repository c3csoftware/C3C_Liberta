@isTest
public class ClassTested {
    public String nome {get;set;}
    public List<MethodTested> metodos = new List<MethodTested>();
    
    public ClassTested(String nome)
    {
        this.nome = nome;
    }

    public void addMethod(
        String methodName,
        List<String> listOfParamNames,
        List<Object> listOfArgs,
        Type returnType,
        Object returnValue
    )
    {
        metodos.add(new MethodTested(
            methodName,
            listOfParamNames,
            listOfArgs,
            returnType,
            returnValue
        ));
    }

    public Boolean containsMethod(String methodName)
    {
        Boolean contains = false;
        for(MethodTested metodo : this.metodos)
        {
            contains = metodo.methodName == methodName;
            if(contains)
                break;
        }
            
        return contains;
    }
}