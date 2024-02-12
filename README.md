# rupilot.nvim

## Установка

Вам надо установить RUPILOT_KEY в ваши переменные окружения env. 
Например:
Можно добавить `export RUPILOT_KEY=` в ваш .bashrc или .zshrc. Не забудьте применить изменения - `source ~/.zshrc`
Переменые окружения может быть установлена как это устроено в вашей ОС.
Если у вас нету RUPILOT_KEY, надо посетить https://rupilot.ru и создать новый ключ после регистрации.


Установка с помощью lazy.nvim. [nui.nvim](https://github.com/MunifTanjim/nui.nvim) это обязательная библиотека для работы rupilot.nvim.

```lua
-- rupilot.nvim
{
  'Partysun/rupilot.nvim', dependencies = { "MunifTanjim/nui.nvim" }
}
```

## Как пользоваться?

Запустить команду `:Rupilot` без аргументов для запуска окна ввода вопросов для rupilot
или сразу напишите вам вопрос к Rupilot в строчку аргументами: `:Rupilot python torch create a tensor scalar`

---
Шоткаты:

 - Открыть окно ввода вопросов - `<leader>aa`

 - Выделите любой блок кода и нажмите - `<leader>ae`
Откроется форма для ввода вопроса, в котором можно указать вопрос относительно выделенного блока кода.
