public without sharing class TaskCallServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'criarAtualizarTarefaChamada' => 'ADP_CriarAtualizarTarefaChamada',
            'obterTarefasChamadasDoUsuarioAtual' => 'ADP_ObterTarefasChamadasDoUsuarioAtual',
            'tranferirChamada' => 'ADP_TranferirChamada',
            'criarAtualizarTarefaRedirecionamentoLigacao' => 'ADP_CriarAtualizarTarefaRedirecLigacao'
        };
    }
}