## 📋 Descrição

_O que foi alterado, por quê, e qual impacto esperado?_

---

## 🔗 Issue relacionada

Fixes #(número)

---

## 🧪 Tipo de mudança

- [ ] 🐛 `fix:` Correção de bug
- [ ] ✨ `feat:` Nova funcionalidade
- [ ] ♻️ `refactor:` Refatoração (sem feat ou fix)
- [ ] 📚 `docs:` Documentação
- [ ] ⚡ `perf:` Melhoria de performance
- [ ] 💥 Breaking change (requer migração de dados do localStorage)

---

## 🖥️ Como testar

Passos para reproduzir e validar a mudança:

1. Abra `OrganizaApp.html` no navegador
2. ...
3. Resultado esperado: ...

---

## ✅ Checklist

**Código:**
- [ ] Segue convenção BEM no CSS
- [ ] Todos os eventos usam `addEventListener` (zero atributos `onclick` inline)
- [ ] Funções internas têm prefixo `_`
- [ ] Nenhum `console.log` de debug deixado no código
- [ ] `'use strict'` não foi removido

**Dados:**
- [ ] O `localStorage` é preservado após a mudança (testei importar um backup antigo)
- [ ] `createDefaultDB()` foi atualizado se novos campos foram adicionados ao DB
- [ ] `hydrate()` faz merge seguro com os novos campos

**Interface:**
- [ ] Testado no Chrome (versão atual)
- [ ] Testado no Firefox (versão atual)
- [ ] Testado em mobile (responsividade — sidebar colapsável, grids adaptáveis)
- [ ] O logo OA na sidebar permanece estático (não muda com o nome do usuário)
- [ ] O avatar do perfil atualiza em tempo real ao digitar o nome

**Otto:**
- [ ] Se afetou o Otto, testei o mini-panel flutuante e a aba dedicada
- [ ] O histórico do usuário não foi apagado pela mudança

**Documentação:**
- [ ] O `README.md` foi atualizado (se a mudança afeta instalação, uso ou arquitetura)
- [ ] Novas funções têm comentário JSDoc se forem complexas

---

## 📸 Screenshots (se aplicável)

| Antes | Depois |
|-------|--------|
| — | — |
