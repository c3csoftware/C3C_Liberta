public without sharing class AtualizarTarefaServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'atualizarWhatIdParaWhoId' => 'ADP_AtualizarWhatIdParaWhoId'
        };
    }
}