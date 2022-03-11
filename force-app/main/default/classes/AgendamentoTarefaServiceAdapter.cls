public without sharing class AgendamentoTarefaServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterMonitoramentoAgendamentoTarefa' => 'ADP_obterMonitoramentoAgendamentoTarefa'
        };
    }
}