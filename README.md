# 💤 LazyVim

Моя конфигурация [LazyVim](https://github.com/LazyVim/LazyVim).

Лучшая книга по LazyVim: [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)

## C++

Подключены extras `lang.clangd` и `lang.cmake`, отладка (DAP) не используется.
В `lua/plugins/cpp.lua` корнем проекта для clangd считается каталог с `.clangd` или `compile_commands.json`, и только потом каталог с `.git`.
Без этого файлы из зависимостей со своим `.git` (например, `libs/juce`) запускают второй процесс clangd.

### `.clangd` для проектов с unity-сборкой

В unity-сборке (JUCE-модули и подобные) в `compile_commands.json` попадает только главный `.cpp`, который делает `#include "source/*.cpp"`.
Остальные `.cpp` и заголовки не содержат своих `#include`, поэтому clangd разбирает каждый как отдельную единицу и не знает `juce::` и других символов.
Решение: положить `.clangd` в корень проекта и подключать главный заголовок модуля принудительно:

```yaml
CompileFlags:
  CompilationDatabase: cmake-build-with-tests  # каталог сборки, где есть и код, и тесты

Diagnostics:
  UnusedIncludes: None  # include-cleaner шумит при одном главном заголовке

---
If:
  PathMatch: trololo_plugin/(source|include)/.*  # путь относительно каталога с .clangd
CompileFlags:
  Add: [-include, trololo_plugin/trololo_plugin.h]
```

Что учесть:

- `PathMatch` в `.clangd` проекта сопоставляется с путём относительно каталога с этим файлом, поэтому ведущий `.*/` в шаблоне не нужен.
- Путь в `-include` разрешается через `-I` из команды компиляции, в `trololo-plugin` это корень проекта.
- Флаги для файлов, которых нет в базе, clangd берёт у ближайшего файла из `compile_commands.json`, обычно у главного `.cpp`.
- База должна быть сгенерирована с `CMAKE_EXPORT_COMPILE_COMMANDS=ON`. Если удалить каталог сборки, clangd потеряет флаги до новой конфигурации CMake.
- Проверка без редактора: `clangd --check=/путь/к/файлу.h` показывает итоговую команду компиляции и ошибки разбора.

