package com.jk.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class RoleGrant {
	private List<Role> list=new ArrayList<>();
	private Set<Role> roles=new HashSet<>();
	
	private Set<Resource> Resourcess= new HashSet<>();
	private List<Resource> resourceList=new ArrayList<>();
	
	public Set<Resource> getResourcess() {
		return Resourcess;
	}
	public void setResourcess(Set<Resource> resourcess) {
		Resourcess = resourcess;
	}
	public List<Resource> getResourceList() {
		return resourceList;
	}
	public void setResourceList(List<Resource> resourceList) {
		this.resourceList = resourceList;
	}
	public List<Role> getList() {
		return list;
	}
	public void setList(List<Role> list) {
		this.list = list;
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	
	
	
	
}
