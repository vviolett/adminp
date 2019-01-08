package adminp.controller;

import adminp.domain.Message;
import adminp.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.IOException;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(Model model) {
        Iterable<Message> messages = messageRepo.findAll();

        messages = messageRepo.findAll();

        model.addAttribute("products", messages);

        return "main";
    }

    @PostMapping("/main")
    public String add(
            @RequestParam String text,
            @RequestParam String tag, Map<String, Object> model
    ) throws IOException {
        Message message = new Message(text, tag);

        messageRepo.save(message);

        Iterable<Message> products = messageRepo.findAll();

        model.put("products", products);

        return "main";
    }
}
