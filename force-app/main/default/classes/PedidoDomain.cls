public without sharing virtual class PedidoDomain extends PedidoMapper
{
    private class CpfOuCnpjNaoIdentificadoException extends Exception {}

    /**
     * Método responsável por formatar cpf ou cnpj para a sua máscara padrão.
     * CPF: 123.123.123-12
     * CNPJ: 12.123.123/1234-12
     * =========================
     * @param CPF ou CNPJ sem máscara
     * @return CPF ou CNPJ com máscara
     */
    public String formatarCpfOuCnpj(String cpfOuCnpj)
    {
        if(cpfOuCnpj.length() == 11)
        {
            String primeiraParte = cpfOuCnpj.left(3);
            String segundaParte = cpfOuCnpj.substring(3,6);
            String terceiraParte = cpfOuCnpj.substring(6,9);
            String digito = cpfOuCnpj.right(2);

            return primeiraParte+'.'+segundaParte+'.'+terceiraParte+'-'+digito;
        }
        else if(cpfOuCnpj.length() == 14)
        {
            String primeiraParte = cpfOuCnpj.left(2);
            String segundaParte = cpfOuCnpj.substring(2,5);
            String terceiraParte = cpfOuCnpj.substring(5,8);
            String quartaParte = cpfOuCnpj.substring(8,12);
            String digito = cpfOuCnpj.right(2);

            return primeiraParte+'.'+segundaParte+'.'+terceiraParte+'/'+quartaParte+'-'+digito;
        }
        else 
        {
            throw new CpfOuCnpjNaoIdentificadoException('Não foi possível identificar o CPF ou CNPJ passado, verifique se é válido.');    
        }

    }

}