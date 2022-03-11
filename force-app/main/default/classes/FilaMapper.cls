public without sharing class FilaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
	public override String getObjectName()
    {
        return 'Fila__c';
    }

    //Atributos (Com referência ao campo do objeto)

    @AuraEnabled 
    public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled 
    public String nomeFila
    {
        get;
        set
        {
            this.nomeFila = value;
            this.setValueInRecord('Name', value);
        }
    }

    //Construtores

    public FilaMapper()
    {}

    //Construtor resposável por construir a instância com um SObject
    private FilaMapper(SObject filaSObject)
    {
        this.construirFilaMapperComFilaSObject(filaSObject);
    }

    //Métodos

    //Método responsável por retornar a instância da classe caso passe parâmetros
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new FilaMapper((Sobject) params);

        return null;
    }

    //Método responsável por construir a fila Mapper caso receba um sObject de fila
    private void construirFilaMapperComFilaSObject(SObject filaSObject)
    {
        this.record = filaSObject;

        this.idRegistro = (String) filaSObject.get('Id');
        this.nomeFila = (String) filaSObject.get('Name');
    }
}