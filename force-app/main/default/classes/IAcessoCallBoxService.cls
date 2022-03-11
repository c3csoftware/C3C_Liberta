public interface IAcessoCallBoxService 
{
    UserCallBoxViewModel obterInformacoesDoLoginCallBoxDoUsuarioAtual(); //Responsável por buscar as informações de login do callbox do usuário atual
    void salvarInformacoesAcessoCallboxUsuarioAtual(String ramalUsuario, String senhaCallbox); //Responsável por salvar as informações login callbox
    void registrandoRamal(String ramal, String identificacaoGuia);
}