public without sharing virtual class CasoDomain extends CasoMapper 
{
    private class CasoDomainException extends Exception {}

    //Atributos
    public Boolean casoCriadoPorAssessor
    {
        get;
        set
        {
            this.casoCriadoPorAssessor = value;
        }
    }

    //
    //Métodos
    //

    public void definirAtributosMapper(String proprietario, String assessorQueRequisitou, String origem, String categoria)
    {
        this.proprietario = proprietario;
        this.assessorQueRequisitou = assessorQueRequisitou;
        this.origem = origem;
        this.categoria = categoria;
    }

    public void definirAssessorQueRequisitouCaso()
    {
        if ((this.categoria == 'BackOffice' || this.categoria == 'Trader') && this.origem == 'Assessor')
        {
            this.casoCriadoPorAssessor = true;
        }
        else 
        {
            this.casoCriadoPorAssessor = false;
        }
    }

    public String definirProprietarioCasoPorFilaCategoriaTrader(String papelUsuarioContexto, List<MembroEquipeMapper> listaMembroEquipe, Map<String, GroupMapper> mapGroupMapperPorNomeFila )
    {
        Map<String, String> mapaNomeFilaPorPapelUsuario = new Map<String, String>{
            'MD' => '[Trader] Mesa Digital',
            'BC' => '[Trader] Balneário Camburiú',
            'PELOTAS' => '[Trader] Pelotas',
            'CAMPINAS' => '[Trader] Campinas',
            'Hunter' => '[Trader] Hunters',
            'LENÇÓIS PAULISTA' => '[Trader] Lençóis Paulista',
            'SSC' => '[Trader] São Sebastião do Caí'
        };

        if (papelUsuarioContexto == null)
        {
            throw new CasoDomainException('O usuário não possue Papel cadastrado. Entre em contato com o Adminstrador do Sistema');
        }
        else 
        {
            Boolean verificado = false;
            for (String variavel : mapaNomeFilaPorPapelUsuario.keySet())
            {
                if (!verificado && papelUsuarioContexto.contains(variavel))
                {
                    verificado = true;
                    return  mapGroupMapperPorNomeFila.get(mapaNomeFilaPorPapelUsuario.get(variavel)).recordId;
                }
            }

            if (!verificado)
            {
                return this.verificarEquipeCorrespondentePorFila(listaMembroEquipe, mapGroupMapperPorNomeFila);  
            }
        }

        return '';
    }

    private String verificarEquipeCorrespondentePorFila(List<MembroEquipeMapper> listaMembroEquipe, Map<String, GroupMapper> mapGroupMapperPorNomeFila)
    {
        Map<String, String> mapa = new Map<String, String>
        {
            'Equipe Geraldo Vargas' => '[Trader] Equipe Geraldo Vargas',
            'Equipe André Moreira' => '[Trader] Equipe André Moreira',
            'Equipe Jonas Tolotti' => '[Trader] Equipe Jonas Tolotti'

        };

        Boolean verificado = false;
        for (MembroEquipeMapper membroEquipeMpp : listaMembroEquipe)
        {
            if( !verificado && mapa.get(membroEquipeMpp.nomeEquipe) != null)
            {
                verificado = true;
                return mapGroupMapperPorNomeFila.get(mapa.get(membroEquipeMpp.nomeEquipe)).recordId;
            }
        }

        if (!verificado)
        {
            throw new CasoDomainException('Usuário não está em nenhuma equipe, entre em contato com o Adminstrador do Sistema. ');
        }

        return '';
    }
}