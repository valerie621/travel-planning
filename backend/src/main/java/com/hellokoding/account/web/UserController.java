package com.hellokoding.account.web;

import com.hellokoding.account.model.User;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.UserService;
import com.hellokoding.account.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import java.util.*;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import com.hellokoding.account.model.Location;
import net.sf.json.JSONObject;
import com.hellokoding.account.model.Path;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/userhome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout, HttpServletRequest request) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }


    @RequestMapping(value = "/employeeinfo", method = RequestMethod.GET)
    public String employeeinfo(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your have no authority to view the info");

        if (logout != null)
            model.addAttribute("message", "Here are the employee information.");

        return "employee";
    }

    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName(); //get logged in username

        model.addAttribute("username", name);
        return "home";
    }

    @RequestMapping(value = {"/userhome"}, method = RequestMethod.GET)
    public String home(Model model) {
        return "userhome";
    }

    @RequestMapping(value = {"/mapdetail"}, method = RequestMethod.GET)
    public String mapdetail(Model model, @RequestParam("destination") String destination, @RequestParam(value="day", required = false, defaultValue = "3") String day) {
        int daytime = Integer.parseInt(day);
        List<Integer> list = new ArrayList<Integer>();
        for (int i = 1; i <= daytime; ++i) {
            list.add(i);
        }
        //model.addAttribute("travelPeriod", list);
        HashMap<String, List<Location>> location = new HashMap<>();
        List<Location> location_list = new ArrayList<Location>();
        List<List<Path>> path = new ArrayList<>();
        location_list.add(new Location("Bondi Beach", -33.890542, 151.274856, 4));
        location_list.add(new Location("Coogee Beach", -33.923036, 151.259052, 5));
        location_list.add(new Location("Cronulla Beach", -34.028249, 151.157507, 3));
        location_list.add(new Location("Manly Beach", -33.80010128657071, 151.28747820854187, 2));
        location_list.add(new Location("Maroubra Beach", -33.950198, 151.259302, 1));
        List<Path> temp = new ArrayList<>();
        String Description = "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.";
        for (int i = 0; i < location_list.size() - 1; ++i) {
            String name = location_list.get(i).getName() + " to " + location_list.get(i + 1).getName();
            String start = "" + i;
            String end = "" + (i + 1);
            temp.add(new Path(name, start, location_list.get(i).getName(), end, location_list.get(i + 1).getName(), "one hour", Description, Description));
        }
        for (int i= 1; i <= Integer.parseInt(day); ++i) {
              location.put(i + "", location_list);
              path.add(temp);
        }
        JSONObject jsonObject = JSONObject.fromObject(location);
        model.addAttribute("locationInfo", jsonObject);
        model.addAttribute("path", path);
        model.addAttribute("destination", destination);
        model.addAttribute("day", day);
        return "mapdetailtest";
    }

    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "home";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
    }

    @RequestMapping(value="/flowchart", method = RequestMethod.GET)
    public String flowchart () {
        return "flowchart";
    }

    @RequestMapping(value="/profile", method = RequestMethod.GET)
    public String profile () {
        return "profile";
    }

    @RequestMapping(value ={"/delete"}, method = RequestMethod.GET)
    public String delete(HttpServletRequest requ, HttpServletResponse resp) {

        Map myModel = new HashMap();

        // get the Authentication of the user who is logged in.
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        try {
            User user = userService.findByUsername(auth.getName());
            userService.delete(user);
        } catch (Exception e) {
            myModel.put("deleted", "Your account could not be deleted. Please contact our support team.");
        }

        return "home";
    }
}
