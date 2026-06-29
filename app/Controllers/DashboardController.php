<?php

class DashboardController
{
    private PDO $pdo;

    public function __construct()
    {
        require __DIR__ . '/../../config/database.php';
        $this->pdo = $pdo;
    }

    private function json(array $dados, int $status = 200): void
    {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($dados, JSON_UNESCAPED_UNICODE);
    }

    public function resumo(): void
    {
        try {
            $pessoas = (int) $this->pdo
                ->query("SELECT COUNT(*) FROM pessoas WHERE status = 'ativo'")
                ->fetchColumn();

            $tipos = (int) $this->pdo
                ->query("SELECT COUNT(*) FROM tipos_atendimentos WHERE status = 'ativo'")
                ->fetchColumn();

            $atendimentos = (int) $this->pdo
                ->query('SELECT COUNT(*) FROM atendimentos')
                ->fetchColumn();

            $this->json([
                'pessoas' => $pessoas,
                'tipos' => $tipos,
                'atendimentos' => $atendimentos,
            ]);
        } catch (PDOException $e) {
            $this->json(['erro' => 'Erro ao carregar o resumo do dashboard.'], 500);
        }
    }
}
