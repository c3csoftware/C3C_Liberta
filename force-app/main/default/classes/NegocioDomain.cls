public without sharing class NegocioDomain extends NegocioMapper implements INegocioDomain
{
    //
    //Métodos
    //

    //Responsável por definir a fila dono do negócio
    public void definirFilaDoNegocio(String nomeFila, String idFila)
    {
        // Feito essa modificação para que seja possível colocar nomeFila, quando não tem deals, nem Leads no estágio.
        if (String.isEmpty(idFila))
            this.nomeFila = nomeFila;
        else
        {
            this.nomeFila = nomeFila;
            this.proprietario = idFila;
        }
    }

    //Responsável por definir o usuário dono do negócio
    public void definirUsuarioProprietarioDoNegocio(String idUsuario)
    {
        if(String.isEmpty(idUsuario))
        {
            this.usuarioNaoIdentificado = true;
            this.proprietario = UserInfo.getUserId();
        }
        else
            this.proprietario = idUsuario;
    }
}