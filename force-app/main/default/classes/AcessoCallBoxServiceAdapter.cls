public without sharing class AcessoCallBoxServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'obterInformacoesDoLoginCallBoxDoUsuarioAtual' => 'ADP_ObterInforLoginCallBoxUsuarioAtual',
            'salvarInformacoesAcessoCallboxUsuarioAtual' => 'ADP_SalvarInforAcessoCallboxUsuarioAtual',
            'registrandoRamal' => 'ADP_RegistrandoRamal'
        };
    }
}