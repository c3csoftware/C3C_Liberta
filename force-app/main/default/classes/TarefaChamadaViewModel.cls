public without sharing class TarefaChamadaViewModel implements C3C_DI_IProvider
{
    //
    //Atributos
    //

    @AuraEnabled public String idTarefa {get;set;}
    @AuraEnabled public String numeroCelular {get;set;}
    @AuraEnabled public String dataLigacao {get;set;}

    //
    //Construtores
    //

    public TarefaChamadaViewModel()
    {}

    private TarefaChamadaViewModel(String idTarefa, String numeroCelular, Datetime dataLigacao)
    {
        this.idTarefa = idTarefa;
        this.numeroCelular = numeroCelular;
        this.dataLigacao = this.converterDatetimeParaString(dataLigacao);
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametros = (Map<String, Object>) params;

            return new TarefaChamadaViewModel((String) mapaParametros.get('idTarefa'), (String) mapaParametros.get('numeroCelular'), (Datetime) mapaParametros.get('dataLigacao'));
        }
           
        return null;
    }

    private String converterDatetimeParaString(Datetime dataLigacao)
    {
        if(dataLigacao == null)
            return null;

        Integer dia = dataLigacao.day();
        Integer mes = dataLigacao.month();
        Integer ano = dataLigacao.year();
        
        Integer hora = dataLigacao.hour()-3;
        Integer minuto = dataLigacao.minute();

        return this.formatarNumero(dia)+'/'+this.formatarNumero(mes)+'/'+ano+' '+this.formatarNumero(hora)+':'+this.formatarNumero(minuto);
    }

    private String formatarNumero(Integer numero)
    {
        return numero < 10 ? '0'+numero : String.valueOf(numero);
    }
}