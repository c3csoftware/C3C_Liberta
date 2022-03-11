public interface ICadastroAcessoCallBoxService
{
    void publicarEventoCadastroAcessoCallBox(String idUsuario, String ramalUsuario, String senhaCallbox); //Responsável por publicar o evento de CadastroAcessoCallbox com as informações do acesso.
    void cadastrarOuAtualizarInformacoesAcessoCallboxNoUsuario(List<ICadastrarAcessoAoCallboxDomain> listaCadAcessoCallbox); //Responsável por salvar as informações do acesso ao callbox no usuário.
}