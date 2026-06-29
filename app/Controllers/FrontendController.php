<?php

class FrontendController
{
    public function __construct()
    {
        // Garante que nenhuma página visual seja aberta sem sessão ativa
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        require_once __DIR__ . '/../Middleware/auth.php';
        exigirAutenticacao();
    }

    public function pessoas(): void
    {
        $tituloPagina = 'Pessoas Atendidas';
        require_once __DIR__ . '/../Views/pessoas/index.php';
    }

    public function tipos(): void
    {
        $tituloPagina = 'Tipos de Atendimento';
        require_once __DIR__ . '/../Views/tipos-atendimentos/index.php';
    }

    public function atendimentos(): void
    {
        $tituloPagina = 'Atendimentos';
        require_once __DIR__ . '/../Views/atendimentos/index.php';
    }
}