---
title: Virtual Environment - 虛擬環境
date: 2017-06-18 22:47:38
tags: [Programming, Tool]
---

# Virtual Environment - 虛擬環境

Virtual Environment 是開發專案時很常用到的工具，通常稱為 `virtualenv`。

常見的功能像是：

### 1. 使用特定版本的 Runtime 或 Interpreter

如果我同時在開發兩個專案，這兩個專案需要用到不同的版本的 node 環境或 go 編譯工具鍊，
但是我又不想每次都打超長的路徑去指定特定版本的 node (go)。這時虛擬環境就可以派上用場。

### 2. 隔離 Library, Package 的安裝環境

Python 和 Ruby 等語言都有自帶套件管理工具 `pip` 及 `gem`。這兩個套件管理工具都是將
套件安裝在使用者的家目錄下 (在此我們先不考慮系統目錄的使用)。 如果我有兩個專案同時
都會用到某套件 foo，但一個需要 foo@1.0.0 另一個需要 foo@2.0.0，這時就會造成套件的
版本衝突，必須靠虛擬環境來解決。

### 3. 設定一些必要的環境變數，像是 `PATH` 等

許多開發工具會依據特定的環境變數來運作，像是 Python 會看 `PYTHONPATH`， Golang 會看
`GOPATH`，這時我們就可以透過設定環境變數，來控制專案中這些開發工具的行為。

其實前兩項基本上也都是靠設定環境變數來實現的 XD

有一定人氣以上的程式語言基本上都會有類似的工具可以使用，像是 Python 的 `virtualenv`，
Golang 的 `goenv` 等等。

## 用法

各類虛擬環境工具的安裝和建立方式各不相同，所以這邊先講一些比較共同的概念。

虛擬環境常見的用法是透過一個名為 `activate` 的 shell script，用 `source activate`
的方式啟用該虛擬環境，這個過程中會有意的去修改一些重要的環境變數。
通常該虛擬環境在啟用的同時，也會定義一個 `deactivate` 函式。方便讓使用者可以
回到啟用虛擬環境前的狀態。

## 範例

以下是我自己參考 Python 的 `virtualenv` 專案所寫的一個簡單實作，用途是方便 Node.js
開發環境的指令調用。

``` sh
#!/bin/sh

# Define deactivate function to exit virtual environment
deactivate () {
  export PATH="${_OLD_PATH}"
  export PS1="${_OLD_PS1}"

  unset -f deactivate
}

# Backup old environment variables
_OLD_PATH="$PATH"
_OLD_PS1="$PS1"

# Give desired values to environment viraibles
export PATH="$(npm bin):$PATH"
export PS1="(node-mode) $PS1"

# Clear command cache
if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
  hash -r 2>/dev/null
fi
```

可以看到我在 `PATH` 變數前面加了一個 `node_modules/.bin` (`$(npm bin)` 的輸出結果)
，讓我們可以直接執行透過 npm 區域安裝的工具程式，而不必打出完整的路徑。
並且為了提醒自己目前有啟用虛擬環境，我修改了 `PS1` 變數，在最前面加了 `(node-mode)`
來提醒使用者。

當然為了解除虛擬環境，我們有將就的 `PATH`，`PS1` 保存下來，並定義一個 `deactivate`
函式來方便解除。

值得一提的是，有些 shell 環境會幫已經找過絕對路徑的指令建立 cache，這會導致虛擬環境
的工具沒辦法完整的切割執行的指令版本。這時候我們可以透過 `hash -r` 來清除這些已經
建立的 cache。

## 結語

經過超簡短的介紹後，相信大家可以體會這類工具的實用性。如果哪天需要同時管理多個專案，
或單純不想汙染自己的家目錄的 `bin` 資料夾，都可找虛擬環境來用用看！
