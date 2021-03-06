package audites.domain;

import audites.domain.Department;
import audites.domain.Revision;
import audites.domain.Role;
import com.google.common.collect.Iterables;
import java.util.List;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Observable
@Accessors
@Entity
@SuppressWarnings("all")
public class User {
  @Id
  @GeneratedValue
  private Long id;
  
  @Column
  private String name;
  
  @Column
  private String username;
  
  @Column
  private String password;
  
  @Column
  private String email;
  
  @ManyToMany(fetch = FetchType.LAZY)
  private List<Department> departments = CollectionLiterals.<Department>newArrayList();
  
  @ManyToMany(fetch = FetchType.LAZY)
  private List<Role> roles = CollectionLiterals.<Role>newArrayList();
  
  @ManyToMany(fetch = FetchType.LAZY)
  private List<Revision> revisions = CollectionLiterals.<Revision>newArrayList();
  
  @Column
  private Boolean enabled = Boolean.valueOf(true);
  
  public User() {
    this.name = "";
    this.username = "";
    this.password = "";
    this.email = "";
  }
  
  public User(final String n, final String u, final String p, final String m) {
    this.name = n;
    this.username = u;
    this.password = p;
    this.email = m;
  }
  
  public void addDepartment(final Department dep) {
    boolean _contains = this.departments.contains(dep);
    boolean _not = (!_contains);
    if (_not) {
      this.departments.add(dep);
    }
  }
  
  public void removeDepartment(final Department dep) {
    boolean _contains = this.departments.contains(dep);
    if (_contains) {
      this.departments.remove(dep);
    }
  }
  
  public boolean addRole(final Role role) {
    boolean _xifexpression = false;
    boolean _contains = this.roles.contains(role);
    boolean _not = (!_contains);
    if (_not) {
      _xifexpression = this.roles.add(role);
    }
    return _xifexpression;
  }
  
  public boolean removeRole(final Role role) {
    boolean _xifexpression = false;
    boolean _contains = this.roles.contains(role);
    if (_contains) {
      _xifexpression = this.roles.remove(role);
    }
    return _xifexpression;
  }
  
  public void addRevision(final Revision rev) {
    boolean _contains = this.revisions.contains(rev);
    boolean _not = (!_contains);
    if (_not) {
      this.revisions.add(rev);
    }
  }
  
  public List<Revision> getRevisions() {
    final Function1<Department, Set<Revision>> _function = new Function1<Department, Set<Revision>>() {
      public Set<Revision> apply(final Department it) {
        return it.getRevisions();
      }
    };
    List<Set<Revision>> _map = ListExtensions.<Department, Set<Revision>>map(this.departments, _function);
    Iterable<Revision> _flatten = Iterables.<Revision>concat(_map);
    return IterableExtensions.<Revision>toList(_flatten);
  }
  
  public Set<String> getDepartmentsNames() {
    final Function1<Department, String> _function = new Function1<Department, String>() {
      public String apply(final Department it) {
        return it.getName();
      }
    };
    List<String> _map = ListExtensions.<Department, String>map(this.departments, _function);
    return IterableExtensions.<String>toSet(_map);
  }
  
  public void changeStatus(final Boolean b) {
    this.enabled = b;
  }
  
  @Pure
  public Long getId() {
    return this.id;
  }
  
  public void setId(final Long id) {
    this.id = id;
  }
  
  @Pure
  public String getName() {
    return this.name;
  }
  
  public void setName(final String name) {
    this.name = name;
  }
  
  @Pure
  public String getUsername() {
    return this.username;
  }
  
  public void setUsername(final String username) {
    this.username = username;
  }
  
  @Pure
  public String getPassword() {
    return this.password;
  }
  
  public void setPassword(final String password) {
    this.password = password;
  }
  
  @Pure
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(final String email) {
    this.email = email;
  }
  
  @Pure
  public List<Department> getDepartments() {
    return this.departments;
  }
  
  public void setDepartments(final List<Department> departments) {
    this.departments = departments;
  }
  
  @Pure
  public List<Role> getRoles() {
    return this.roles;
  }
  
  public void setRoles(final List<Role> roles) {
    this.roles = roles;
  }
  
  public void setRevisions(final List<Revision> revisions) {
    this.revisions = revisions;
  }
  
  @Pure
  public Boolean getEnabled() {
    return this.enabled;
  }
  
  public void setEnabled(final Boolean enabled) {
    this.enabled = enabled;
  }
}
