public with sharing class BuscarPopTarefaServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterTarefaPorIdComPop' => 'ADP_ObterTarefaPorIdComPop'
        };
    }
}